![MapmyIndia APIs](https://www.mapmyindia.com/api/img/mapmyindia-api.png)

# Troubleshooting

## [List of problems related to Map integration:-](#List-of-problems-related-to-Map-integration:-)

### **Problem 1: `MapmyIndia.framework damaged`**
   Sometimes an error `MapmyIndia.framework damaged` shows on opening a **storyboard** file.

**Screenshot:-**

   ![Problem 1](https://s3-ap-south-1.amazonaws.com/mmi-api-team/moveSDK/GithubDocs/VectorSDK/Wiki/TroubleshootingAssets/Problem1_MapmyIndiaFrameworkDamaged.png)
    
### **Solution:**

Use `xattr` on the framework Throwing the Damaged Error.With the command line you can use xattr to remove error message “MapmyIndia.framework is damaged and can’t be opened. It may be due to  application downloaded from the internet. So `Launch Terminal` and then issue the following command:
```
xattr -cr /path/to/MapmyIndia.framework
```

<br/>

### **Problem 2: `Image not found`**

Facing the issue of `Reason:image not found` on launch of application after integrating MapmyIndia's SDK frameworks. 

**Screenshot:-**

 ![Problem 2](https://s3-ap-south-1.amazonaws.com/mmi-api-team/moveSDK/GithubDocs/VectorSDK/Wiki/TroubleshootingAssets/Problem2_ImageNotFound.png)

### **Solution:**
- First confirm required framework added to your project.
- Go to `General` tab in project settings and under the section `Frameworks,Libraries and Embedded Content` select `Embed & Sign` for each MapmyIndia's framework like MapmyIndiaAPIKit, MapmyIndiaDirections etc.

**Screenshot:-**

![Solution 2](https://s3-ap-south-1.amazonaws.com/mmi-api-team/moveSDK/GithubDocs/VectorSDK/Wiki/TroubleshootingAssets/Solution2_ImageNotFound.png)

<br/>

### **Problem 3: `App Store submission with the Maps SDK for iOS`**

If you have installed the MapmyIndia Maps SDK for iOS manually, you may see an App Store bug that results in the following error when submitting your application to the App Store:

_ERROR ITMS-90087: Unsupported Architectures. The executable for YourApp.app/Frameworks/MapmyIndia.framework contains unsupported architectures '[x86_64, i386]'_

### **Solution:**

To avoid this, you'll need to add the following script in the Build Phases tab of your project. This script will remove architectures for simulators, which is not necessary for App Store submission.

```
"${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/MapmyIndia.framework/strip-frameworks.sh"
```
<br/>

### **Problem 4: `PhaseScriptExecution failed`**

Such types of errors occur due to script failure of the project.
`strip-frameworks.sh` is a script file, that is embedded in `MapmyIndia.framework` and used to remove simulator architectures from the application package.
Below is dynamic path to above mentioned script file:
`bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/strip-frameworks.sh"`

**Screenshot:-**

![Problem 4](https://s3-ap-south-1.amazonaws.com/mmi-api-team/moveSDK/GithubDocs/VectorSDK/Wiki/TroubleshootingAssets/Problem4_PhaseScriptExecutionFailed.png)

### **Solution:**

Initially you can remove the Run Script from Build Phase because it is only required while publishing app on store.

_**Or**_

While packaging manually set script path in Build Phase as shown in given screenshot.
Go to project setting click on `Build Phase` add the `Run Script`.

**Screenshot:-**

![Solution 3](https://s3-ap-south-1.amazonaws.com/mmi-api-team/moveSDK/GithubDocs/VectorSDK/Wiki/TroubleshootingAssets/Solution4_PhaseScriptExecutionFailed.png)