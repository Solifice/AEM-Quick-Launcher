# AEM Quick Launcher

## **Use at your own risk. I am not responsible for any consequences.**

## About
**AEM** also known as **Adobe Experience Manager** lets you create, manage, optimise and deliver digital experiences across channels. And you can ensure that your content across web, mobile and apps is built efficiently and delivered quickly. [Know More](https://business.adobe.com/in/products/experience-manager/adobe-experience-manager.html)

People working on AEM typically use the AEM SDK JAR file locally for development and testing. Sometimes, it's necessary to run AEM in normal mode, while other times it's required to run it in debug mode. Running the AEM SDK in debug mode can be cumbersome, as it involves opening a terminal and copying and pasting commands to start the SDK in debug mode. Similarly, if someone is using a ZIP distribution of the JDK, starting the AEM SDK can present the same challenge.

**AEM Quick Launcher** is a batch script designed to address the issue described. It requires the path to the JAR file and the debug port number as inputs. Upon execution, the script presents a menu prompting the user to choose between starting AEM in normal mode or debug mode. Users can simply press keys to make their selection, making it very convenient. Additionally, the script streamlines the process for individuals using ZIP distribution of the JDK on their local systems to start AEM.

## Limitations
- Since it's a batch file, it will only work on Windows systems.

## Download
The script can be downloaded by either cloning it or downloading it from the releases section.

## Installation & Quick Start
1. This script does not require any formal installation process.
2. Feel free to copy and paste the batch script anywhere you'd like.
3. Open the batch file using any text editor of your choice.
4. Set the DEBUG_PORT and JAR_PATH. Optionally, set the JDK_PATH if using a ZIP distribution of the JDK. In my case, the DEBUG_PORT is 8000, the JAR_PATH is similar to "C:\aem-author-p4502.jar", and the JDK_PATH can be "C:\jdk\bin".
5. Save the changes and close the file.
6. Now, simply double-click the batch file, and you're all set!

## Contributions
- Report bugs, ask questions and suggest new features by creating a new issue.
- Donate to [**Solifice**](https://linktr.ee/solifice).

## Credits
1. This script utilizes the Adobe Experience Manager (AEM) SDK for running AEM instance. We acknowledge and appreciate the functionality provided by AEM SDK. For more information about AEM, visit [Adobe's AEM website](https://business.adobe.com/in/products/experience-manager/adobe-experience-manager.html).
2. This script is written in batch and utilizes batch scripting for automation. We acknowledge and appreciate the functionality provided by batch scripting.
