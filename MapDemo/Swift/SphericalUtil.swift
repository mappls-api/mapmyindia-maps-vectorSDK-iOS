//
//  SphericalUtil.swift
//  MapDemo
//
//  Created by apple on 14/08/19.
//  Copyright © 2019 MMI. All rights reserved.
//

import Foundation
import Mapbox

public class SphericalUtil {
    init() {
    }
    
    class func computeHeading(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
        let fromLat = from.latitude.toRadians()
        let fromLon = from.longitude.toRadians()
        let toLat = to.latitude.toRadians()
        let toLon = to.longitude.toRadians()
        let dLng = (toLon - fromLon)
        let heading = atan2(sin(dLng) * cos(toLat), cos(fromLat) * sin(toLat) - sin(fromLat) * cos(toLat) * cos(dLng))
        return MathUtil.wrap(heading.toDegrees(), -180.0, 180.0)
    }
    
    class func computeOffset(from: CLLocationCoordinate2D, distance: Double, heading: Double) -> CLLocationCoordinate2D {
        let newDistance = distance / 6371009.0
        let newHeading = heading.toRadians()
        let fromLat = from.latitude.toRadians()
        let fromLng = from.longitude.toRadians()
        let cosDistance = cos(newDistance);
        let sinDistance = sin(newDistance);
        let sinFromLat = sin(fromLat);
        let cosFromLat = cos(fromLat);
        let sinLat = cosDistance * sinFromLat + sinDistance * cosFromLat * cos(newHeading);
        let dLng = atan2(sinDistance * cosFromLat * sin(newHeading), cosDistance - sinFromLat * sinLat);
        return CLLocationCoordinate2DMake(asin(sinLat).toDegrees(), (fromLng + dLng).toDegrees())
    }
    
    class func computeOffsetOrigin(to: CLLocationCoordinate2D, distance: Double, heading: Double) -> CLLocationCoordinate2D? {
        let newHeading = heading.toRadians();
        let newDistance = distance / 6371009.0;
        let n1 = cos(newDistance);
        let n2 = sin(newDistance) * cos(newHeading);
        let n3 = sin(newDistance) * sin(newHeading);
        let n4 = sin(to.latitude.toRadians());
        let n12 = n1 * n1;
        let discriminant = n2 * n2 * n12 + n12 * n12 - n12 * n4 * n4;
        if (discriminant < 0.0) {
            return nil
        } else {
            var b = n2 * n4 + sqrt(discriminant);
            b /= n1 * n1 + n2 * n2;
            let a = (n4 - n2 * b) / n1;
            var fromLatRadians = atan2(a, b);
            if (fromLatRadians < -1.5707963267948966 || fromLatRadians > 1.5707963267948966) {
                b = n2 * n4 - sqrt(discriminant);
                b /= n1 * n1 + n2 * n2;
                fromLatRadians = atan2(a, b);
            }
            if (fromLatRadians >= -1.5707963267948966 && fromLatRadians <= 1.5707963267948966) {
                let fromLngRadians = to.longitude.toRadians() - atan2(n3, n1 * cos(fromLatRadians) - n2 * sin(fromLatRadians));
                return CLLocationCoordinate2DMake(fromLatRadians.toDegrees(), fromLngRadians.toDegrees())
            } else {
                return nil
            }
        }
    }
    
    class func interpolate(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, fraction: Double) -> CLLocationCoordinate2D {
        let fromLat = from.latitude.toRadians()
        let fromLng = from.longitude.toRadians()
        let toLat = to.latitude.toRadians()
        let toLng = to.longitude.toRadians()
        let cosFromLat = cos(fromLat);
        let cosToLat = cos(toLat);
        let angle = computeAngleBetween(from, to);
        let sinAngle = sin(angle);
        if (sinAngle < 1.0E-6) {
        return from;
        } else {
            let a = sin((1.0 - fraction) * angle) / sinAngle;
            let b = sin(fraction * angle) / sinAngle;
            let x = a * cosFromLat * cos(fromLng) + b * cosToLat * cos(toLng);
            let y = a * cosFromLat * sin(fromLng) + b * cosToLat * sin(toLng);
            let z = a * sin(fromLat) + b * sin(toLat);
            let lat = atan2(z, sqrt(x * x + y * y));
            let lng = atan2(y, x);
                return CLLocationCoordinate2DMake(lat.toDegrees(), lng.toDegrees())
        }
    }
    
    
    class func distanceRadians(_ lat1: Double,_ lng1: Double,_ lat2: Double,_ lng2: Double) -> Double {
        return MathUtil.arcHav(MathUtil.havDistance(lat1, lat2, lng1 - lng2))
    }
    
    class func computeAngleBetween(_ from: CLLocationCoordinate2D,_ to: CLLocationCoordinate2D) -> Double {
        return distanceRadians(from.latitude.toRadians(), from.longitude.toRadians(), to.latitude.toRadians(), to.longitude.toRadians());
    }
    
    class func computeDistanceBetween(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
        return computeAngleBetween(from, to) * 6371009.0;
    }
    
    class func computeLength(path: [CLLocationCoordinate2D]) -> Double {
        if (path.count < 2) {
            return 0.0;
        } else {
            var length = 0.0;
            let prev = path[0]
            var prevLat = prev.latitude.toRadians()
            var prevLng = prev.longitude.toRadians()
            var lng: Double = 0.0
            
            for i in 0...path.count - 2 {
                let point = path[i+1]
                let lat = point.latitude.toRadians()
                lng = point.longitude.toRadians()
                length += distanceRadians(prevLat, prevLng, lat, lng)
                prevLat = lat
                prevLng = lng
            }
            
            return length * 6371009.0;
        }
    }
    
    class func computeArea(path: [CLLocationCoordinate2D]) ->Double {
        return abs(computeSignedArea(path));
    }
    
    class func computeSignedArea(_ path: [CLLocationCoordinate2D]) -> Double{
    return computeSignedArea(path, 6371009.0);
    }
    
    class func computeSignedArea(_ path: [CLLocationCoordinate2D],_ radius: Double) -> Double{
        let size = path.count
        if (size < 3) {
            return 0.0;
        } else {
            var total = 0.0;
            let prev = path[path.count-1]
            var prevTanLat = tan((1.5707963267948966 - prev.latitude.toRadians()) / 2.0)
            let prevLng = prev.longitude.toRadians()
            var lng: Double = 0.0
            
            for i in 0...path.count - 2 {
                let point = path[i+1]
                let tanLat = tan((1.5707963267948966 - point.latitude.toRadians()) / 2.0)
                lng = point.longitude.toRadians()
                total += polarTriangleArea(tanLat, lng, prevTanLat, prevLng);
                prevTanLat = tanLat;
            }
            return total * radius * radius;
        }
    }
    
    
    class func polarTriangleArea(_ tan1: Double,_ lng1: Double,_ tan2: Double,_ lng2: Double) -> Double {
        let deltaLng = lng1 - lng2;
        let t = tan1 * tan2;
        return 2.0 * atan2(t * sin(deltaLng), 1.0 + t * cos(deltaLng));
    }
}

class MathUtil {
    let EARTH_RADIUS = 6371009.0
    
    init() {
    }
    
    class func clamp(x: Double, low: Double, high: Double) -> Double {
        return x < low ? low : (x > high ? high : x)
    }
    
    class func wrap(_ n: Double,_ min: Double,_ max: Double) -> Double {
        return n >= min && n < max ? n : mod(n - min, max - min) + min
    }
    
    class func mod(_ x: Double,_ m: Double) -> Double {
        return (x.truncatingRemainder(dividingBy: m) + m).truncatingRemainder(dividingBy: m)
    }
    
    class func mercator(lat: Double) -> Double {
        return log(tan(lat * 0.5 + 0.7853981633974483))
    }
    
    class func inverseMercator(y: Double) -> Double {
        return 2.0 * atan(exp(y)) - 1.5707963267948966
    }
    
    class func hav(_ x: Double) -> Double {
        let sinHalf = sin(x * 0.5)
        return sinHalf * sinHalf
    }
    
    class func arcHav(_ x: Double) -> Double {
        return 2.0 * asin(sqrt(x))
    }
    
    class func  sinFromHav(h: Double) -> Double {
        return 2.0 * sqrt(h * (1.0 - h))
    }
    
    class func havFromSin(x: Double) -> Double {
        let x2 = x * x
        return x2 / (1.0 + sqrt(1.0 - x2)) * 0.5
    }
    
    class func sinSumFromHav(x: Double, y: Double) -> Double {
    let a = sqrt(x * (1.0 - x))
    let b = sqrt(y * (1.0 - y))
    return 2.0 * (a + b - 2.0 * (a * y + b * x))
    }
    
    class func havDistance(_ lat1: Double,_ lat2: Double,_ dLng: Double) -> Double {
        return hav(lat1 - lat2) + hav(dLng) * cos(lat1) * cos(lat2)
    }
}

