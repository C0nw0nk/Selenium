@echo off & setLocal EnableDelayedExpansion
:: Copyright Conor McKnight
:: https://github.com/C0nw0nk/Selenium
:: https://www.facebook.com/C0nw0nk
:: Automatically sets up selenium and webdriver for use to be portable to any folder on your pc no python required pip any of that nonsense needed
:: all you need is the batch script it will download the latest versions from their github pages portable selenium!
:: simple fast efficient easy to move and manage
::One file to rule them all,
::One file to find them,
::One file to bring them all,
::and inside cyberspace bind them.
::~Conor McKnight

:: IF you like my work please consider helping me keep making things like this
:: DONATE! The same as buying me a beer or a cup of tea/coffee :D <3
:: PayPal : https://paypal.me/wimbledonfc
:: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=ZH9PFY62YSD7U&source=url
:: Crypto Currency wallets :
:: BTC BITCOIN : 3A7dMi552o3UBzwzdzqFQ9cTU1tcYazaA1
:: ETH ETHEREUM : 0xeD82e64437D0b706a55c3CeA7d116407E43d7257
:: SHIB SHIBA INU : 0x39443a61368D4208775Fd67913358c031eA86D59

:: Script Settings
:settings_load

::once finished tasks on webpage run quit commands to exit selenium to safely close the selenium browser
:: 1 enabled
:: 0 disabled
set close_selenium=0

::internet explorer selenium browser
::disabled by default not needed to use this obviously microsoft depreciated IE and Edge is their future
::i added it since selenium have a maintained IE web driver and some people might want to use it
:: 1 enabled
:: 0 disabled
set internetexplorer_selenium=0

::the webpage we want to access to perform a remote automated task on for IE
set internetexplorer_selenium_browser_url=https://www.bbc.co.uk/

::microsoft edge selenium browser
:: 1 enabled
:: 0 disabled
set microsoftedge_selenium=1

::the webpage we want to access to perform a remote automated task on for Edge
set microsoftedge_selenium_browser_url=https://www.bbc.co.uk/

::chrome selenium browser
:: 1 enabled
:: 0 disabled
set chrome_selenium=1

::the webpage we want to access to perform a remote automated task on for Chrome
set chrome_selenium_browser_url=https://www.bbc.co.uk/

::firefox selenium browser
:: 1 enabled
:: 0 disabled
set firefox_selenium=1

::the webpage we want to access to perform a remote automated task on for firefox
set firefox_selenium_browser_url=https://www.bbc.co.uk/

::brave selenium browser
:: 1 enabled
:: 0 disabled
set brave_selenium=1

::the webpage we want to access to perform a remote automated task on for brave
set brave_selenium_browser_url=https://www.bbc.co.uk/

::vivaldi selenium browser
:: 1 enabled
:: 0 disabled
set vivaldi_selenium=0

::the webpage we want to access to perform a remote automated task on for vivaldi
set vivaldi_selenium_browser_url=https://www.bbc.co.uk/

::opera selenium browser
:: 1 enabled
:: 0 disabled
set opera_selenium=0

::the webpage we want to access to perform a remote automated task on for opera
set opera_selenium_browser_url=https://www.bbc.co.uk/

::Tor selenium browser
:: 1 enabled
:: 0 disabled
set tor_selenium=0

::the webpage we want to access to perform a remote automated task on for Tor
set tor_selenium_browser_url=https://www.bbc.co.uk/

::PhantomJS selenium browser
:: 1 enabled
:: 0 disabled
set phantomjs_selenium=0

::the webpage we want to access to perform a remote automated task on for PhantomJS
set phantomjs_selenium_browser_url=https://www.bbc.co.uk/

::this adds in the ability to make the selenium instance hidden like a background task
::you will not see a browser window appear if you enable headless mode
:: 1 enabled
:: 0 disabled
set headlessbrowser=0

::if we should cleanup our portable folder leaving just this batch script after each use
::default is not to cleanup because its most likely we will run our automated task again
:: 1 enabled
:: 0 disabled
set cleanup=1

::instead of just closing the window after our automated web tasking we pause to view and check once your happy you can set this to 0
:: 1 enabled
:: 0 disabled
set pause_window=1

:: Run this task every 60 seconds
set schedule=60

::Debugging for development and error testing on code
:: 1 enabled
:: 0 disabled
set debug=0

::external selenium script
::this will allow you to modify the selenium script externally if you do not want to do it inside this batch file
::example inside the directory with this batch file you will see a file left every run called chrome-temp.ps1 or firefox-temp.ps1 modify this for your needs
::it wont be deleted and each run time of this batch file it will use this file instead of the inline code in this batch file
:: means you do not need to edit the batch file you can focus on your selenium script modifications without needing to escape batch code
::TODO COMPLETE THIS
:: 1 enabled
:: 0 disabled
set custom_selenium_script=0

:: End Edit DO NOT TOUCH ANYTHING BELOW THIS POINT UNLESS YOU KNOW WHAT YOUR DOING!

TITLE C0nw0nk - Selenium - github.com/C0nw0nk/Selenium

if defined varpass goto :start_exe

set root_path="%~dp0"

::Elevate to admin rights

:start
net session >nul 2>&1
if %errorlevel% == 0 (
goto :admin
) else (
@pushd "%~dp0" & fltmc | find ^".^" && (powershell start '%~f0' ' %*' -verb runas 2>nul && exit /b)
)
goto :start
:admin

:start_loop
if "%~1"=="" (
start /wait /B "" "%~dp0%~nx0" go 2^>Nul
) else (
goto begin
)
goto start_loop
:begin

::End elevation to admin
set varpass=1

if %PROCESSOR_ARCHITECTURE%==x86 (
	set programs_path=%ProgramFiles(x86)%
	set system_folder=System32
) else (
	set programs_path=%ProgramFiles%
	set system_folder=SysWOW64
)

goto :next_download

:start_exe

if not defined close_selenium (
goto :settings_load
)

::Internet Explorer
if %internetexplorer_selenium% == 0 goto :skipie
set global_name=ie
set global_drver_type=IE
set global_drver_type_name=InternetExplorer
::start powershell code
(
if %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path:"=%';
echo Import-Module '%root_path:"=%WebDriver.dll';
echo Import-Module '%root_path:"=%WebDriver.Support.dll';
echo Import-Module '%root_path:"=%Selenium.WebDriverBackedSelenium.dll';
echo #InternetExplorer setup
echo New-ItemProperty "hkcu:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\0" -Name "2500" -Value 0 -PropertyType DWORD -Force ^| Out-Null;
echo New-ItemProperty "hkcu:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" -Name "2500" -Value 0 -PropertyType DWORD -Force ^| Out-Null;
echo New-ItemProperty "hkcu:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" -Name "2500" -Value 0 -PropertyType DWORD -Force ^| Out-Null;
echo New-ItemProperty "hkcu:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "2500" -Value 0 -PropertyType DWORD -Force ^| Out-Null;
echo New-ItemProperty "hkcu:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" -Name "2500" -Value 0 -PropertyType DWORD -Force ^| Out-Null;
echo New-ItemProperty "hkcu:\Software\Microsoft\Internet Explorer\Main" -Name "TabProcGrowth" -Value 0 -PropertyType DWORD -Force ^| Out-Null;
echo New-ItemProperty "hkcu:\Software\Microsoft\Internet Explorer\Zoom" -Name "ZoomFactor" -Value 100000 -PropertyType DWORD -Force ^| Out-Null;
echo $%global_name%Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type_name%Options;
echo $%global_name%Options.InitialBrowserUrl = "https://www.google.co.uk/";
echo #$%global_name%Options.ForceCreateProcessApi = $true;
echo #$%global_name%Options.BrowserCommandLineArguments = "-k";
echo #https://www.selenium.dev/selenium/docs/api/dotnet/html/T_OpenQA_Selenium_IE_InternetExplorerDriverService.htm
echo $%global_name%Service = [OpenQA.Selenium.%global_drver_type%.%global_drver_type_name%DriverService]::CreateDefaultService^(^);
echo $%global_name%Service.HideCommandPromptWindow = $true;
echo $%global_name%Service.SuppressInitialDiagnosticInformation = $true;
echo #$%global_name%Service.LibraryExtractionPath = '%root_path:"=%IEDriverServer.exe';
if %headlessbrowser% == 1 echo $%global_name%Options.AddArgument^('--headless'^);
echo $%global_name%Options.IntroduceInstabilityByIgnoringProtectedModeSettings = $true;
echo $%global_name%Options.IgnoreZoomLevel = $true;
echo $%global_name%Options.EnsureCleanSession = $true;
echo $%global_name%Options.PageLoadStrategy = 'Normal';
echo $%global_name%Options.useCreateProcessApiToLaunchIe^(^);
echo $%global_name%Options.addArgument^(^);
echo $Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type_name%Driver^($%global_name%Service,$%global_name%Options^);
echo $Options.Navigate^(^).GoToURL^('%internetexplorer_selenium_browser_url%'^);
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="bbccookies-continue-button"]/span[1]'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="header-content"]/nav/div[1]/div/div[2]/ul[2]/li[2]/a'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo Start-Sleep -s 2;
echo $pageTitle = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
echo $%global_name%Service.Dispose^(^);
if %close_selenium% == 1 echo $Options.Close^(^);$Options.Quit^(^);
)>"%root_path:"=%%~n0-%global_name%.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" %*
if %debug% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
:skipie

::Microsoft Edge
if %microsoftedge_selenium% == 0 goto :skipedge
set global_name=edge
set global_drver_type=Edge
::https://www.selenium.dev/selenium/docs/api/dotnet/html/N_OpenQA_Selenium_Edge.htm
::start powershell code
(
if %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path:"=%';
echo Import-Module '%root_path:"=%WebDriver.dll';
echo Import-Module '%root_path:"=%WebDriver.Support.dll';
echo Import-Module '%root_path:"=%Selenium.WebDriverBackedSelenium.dll';
echo $%global_name%Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Options;
echo #https://www.selenium.dev/selenium/docs/api/dotnet/html/T_OpenQA_Selenium_Edge_EdgeDriverService.htm
echo $%global_name%Service = [OpenQA.Selenium.%global_drver_type%.%global_drver_type%DriverService]::CreateDefaultService^(^);
echo $%global_name%Service.HideCommandPromptWindow = $true;
echo $%global_name%Service.SuppressInitialDiagnosticInformation = $true;
if %headlessbrowser% == 1 echo $%global_name%Options.AddArgument^('--headless'^);
echo $%global_name%Options.addArgument^("start-maximized"^);
echo $%global_name%Options.addArgument^("-inprivate"^);
echo $%global_name%Options.EnsureCleanSession = $true;
echo $%global_name%Options.PageLoadStrategy = 'Normal';
echo $%global_name%Options.LeaveBrowserRunning = $True;
echo $%global_name%Options.AcceptInsecureCertificates = $True;
echo $%global_name%Options.AddArgument^(^);
echo $Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Driver^($%global_name%Service,$%global_name%Options^);
echo $Options.Navigate^(^).GoToURL^('%microsoftedge_selenium_browser_url%'^);
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="bbccookies-continue-button"]/span[1]'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="header-content"]/nav/div[1]/div/div[2]/ul[2]/li[2]/a'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo Start-Sleep -s 2;
echo $pageTitle = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
echo $%global_name%Service.Dispose^(^);
if %close_selenium% == 1 echo $Options.Close^(^);$Options.Quit^(^);
)>"%root_path:"=%%~n0-%global_name%.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" %*
if %debug% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
:skipedge

::Chrome
if %chrome_selenium% == 0 goto :skipchrome
set global_name=chrome
set global_drver_type=Chrome
::start powershell code
(
if %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path:"=%';
echo Import-Module '%root_path:"=%WebDriver.dll';
echo Import-Module '%root_path:"=%WebDriver.Support.dll';
echo Import-Module '%root_path:"=%Selenium.WebDriverBackedSelenium.dll';
echo $%global_name%Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Options;
echo #https://www.selenium.dev/selenium/docs/api/dotnet/html/T_OpenQA_Selenium_DriverService.htm
echo $%global_name%Service = [OpenQA.Selenium.%global_drver_type%.%global_drver_type%DriverService]::CreateDefaultService^(^);
echo $%global_name%Service.HideCommandPromptWindow = $true;
echo $%global_name%Service.SuppressInitialDiagnosticInformation = $true;
echo $%global_name%Service.DriverServiceExecutableName = 'chromedriver';
if %headlessbrowser% == 1 echo $%global_name%Options.AddArgument^('--headless'^);
echo $%global_name%Options.addArgument^("start-maximized"^);
echo $%global_name%Options.addArgument^("--incognito"^);
echo $%global_name%Options.EnsureCleanSession = $true;
echo $%global_name%Options.PageLoadStrategy = 'Normal';
echo $%global_name%Options.LeaveBrowserRunning = $True;
echo $%global_name%Options.AcceptInsecureCertificates = $true;
echo $%global_name%Options.AddArgument^(^);
echo $Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Driver^($%global_name%Service,$%global_name%Options^);
echo $Options.Navigate^(^).GoToURL^('%chrome_selenium_browser_url%'^);
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="bbccookies-continue-button"]/span[1]'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="header-content"]/nav/div[1]/div/div[2]/ul[2]/li[2]/a'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo Start-Sleep -s 2;
echo $pageTitle = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
echo $%global_name%Service.Dispose^(^);
if %close_selenium% == 1 echo $Options.Close^(^);$Options.Quit^(^);
)>"%root_path:"=%%~n0-%global_name%.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" %*
if %debug% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
:skipchrome

::Firefox
if %firefox_selenium% == 0 goto :skipfirefox
set global_name=firefox
set global_drver_type=Firefox
::start powershell code
(
if %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path:"=%';
echo Import-Module '%root_path:"=%WebDriver.dll';
echo Import-Module '%root_path:"=%WebDriver.Support.dll';
echo Import-Module '%root_path:"=%Selenium.WebDriverBackedSelenium.dll';
echo $%global_name%options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Options;
echo #https://www.selenium.dev/selenium/docs/api/dotnet/html/T_OpenQA_Selenium_Firefox_FirefoxDriverService.htm
echo $%global_name%Service = [OpenQA.Selenium.%global_drver_type%.%global_drver_type%DriverService]::CreateDefaultService^(^);
echo $%global_name%Service.HideCommandPromptWindow = $true;
echo $%global_name%Service.SuppressInitialDiagnosticInformation = $true;
if %headlessbrowser% == 1 echo $%global_name%options.AddArgument^('--headless'^);
echo $%global_name%options.AddArgument^("--kiosk"^);
echo $%global_name%options.AddArgument^("--private-window"^);
echo $%global_name%options.EnsureCleanSession = $true;
echo $%global_name%options.PageLoadStrategy = 'Normal';
echo $%global_name%options.LeaveBrowserRunning = $True;
echo $%global_name%options.AcceptInsecureCertificates = $true;
echo $%global_name%options.AddArgument^(^);
echo $Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Driver^($%global_name%Service,$%global_name%options^);
echo $Options.Url^('%firefox_selenium_browser_url%'^);
echo $Options.Navigate^(^).GoToURL^('%firefox_selenium_browser_url%'^);
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="bbccookies-continue-button"]/span[1]'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="header-content"]/nav/div[1]/div/div[2]/ul[2]/li[2]/a'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo Start-Sleep -s 2;
echo $pageTitle = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
echo $%global_name%Service.Dispose^(^);
if %close_selenium% == 1 echo $Options.Close^(^);$Options.Quit^(^);
)>"%root_path:"=%%~n0-%global_name%.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" %*
if %debug% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
:skipfirefox

::Brave
if %brave_selenium% == 0 goto :skipbrave
set global_name=brave
set global_drver_type=Chrome
::start powershell code
(
if %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path:"=%';
echo Import-Module '%root_path:"=%WebDriver.dll';
echo Import-Module '%root_path:"=%WebDriver.Support.dll';
echo Import-Module '%root_path:"=%Selenium.WebDriverBackedSelenium.dll';
echo $%global_name%Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Options;
echo #https://www.selenium.dev/selenium/docs/api/dotnet/html/T_OpenQA_Selenium_DriverService.htm
echo $%global_name%Service = [OpenQA.Selenium.%global_drver_type%.%global_drver_type%DriverService]::CreateDefaultService^(^);
echo $%global_name%Service.HideCommandPromptWindow = $true;
echo $%global_name%Service.SuppressInitialDiagnosticInformation = $true;
echo $%global_name%Service.DriverServiceExecutableName = 'chromedriver';
if %headlessbrowser% == 1 echo $%global_name%Options.AddArgument^('--headless'^);
echo $%global_name%Options.addArgument^("start-maximized"^);
echo $%global_name%Options.addArgument^("--incognito"^);
echo $%global_name%Options.EnsureCleanSession = $true;
echo $%global_name%Options.PageLoadStrategy = 'Normal';
echo $%global_name%Options.LeaveBrowserRunning = $True;
echo $%global_name%Options.AcceptInsecureCertificates = $true;
echo $%global_name%Options.BinaryLocation = "C:\Users\MEDIA-SERVER\AppData\Local\BraveSoftware\Brave-Browser-Nightly\Application\brave.exe";
echo $%global_name%Options.AddArgument^(^);
echo $Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Driver^($%global_name%Service,$%global_name%Options^);
echo $Options.Navigate^(^).GoToURL^('%brave_selenium_browser_url%'^);
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="bbccookies-continue-button"]/span[1]'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="header-content"]/nav/div[1]/div/div[2]/ul[2]/li[2]/a'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo Start-Sleep -s 2;
echo $pageTitle = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
echo $%global_name%Service.Dispose^(^);
if %close_selenium% == 1 echo $Options.Close^(^);$Options.Quit^(^);
)>"%root_path:"=%%~n0-%global_name%.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" %*
if %debug% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
:skipbrave

::Vivaldi
if %vivaldi_selenium% == 0 goto :skipvivaldi
set global_name=vivaldi
set global_drver_type=Chrome
::start powershell code
(
if %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path:"=%';
echo Import-Module '%root_path:"=%WebDriver.dll';
echo Import-Module '%root_path:"=%WebDriver.Support.dll';
echo Import-Module '%root_path:"=%Selenium.WebDriverBackedSelenium.dll';
echo $%global_name%Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Options;
echo #https://www.selenium.dev/selenium/docs/api/dotnet/html/T_OpenQA_Selenium_DriverService.htm
echo $%global_name%Service = [OpenQA.Selenium.%global_drver_type%.%global_drver_type%DriverService]::CreateDefaultService^(^);
echo #$%global_name%Service.HideCommandPromptWindow = $true;
echo #$%global_name%Service.SuppressInitialDiagnosticInformation = $true;
echo $%global_name%Service.DriverServiceExecutableName = 'chromedriver';
if %headlessbrowser% == 1 echo $%global_name%Options.AddArgument^('--headless'^);
echo $%global_name%Options.addArgument^("start-maximized"^);
echo $%global_name%Options.EnsureCleanSession = $true;
echo $%global_name%Options.PageLoadStrategy = 'Normal';
echo $%global_name%Options.LeaveBrowserRunning = $True;
echo $%global_name%Options.AcceptInsecureCertificates = $true;
echo $%global_name%Options.BinaryLocation = "C:\Users\MEDIA-SERVER\AppData\Local\Vivaldi\Application\vivaldi.exe";
echo $%global_name%Options.AddArgument^(^);
echo $Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Driver^($%global_name%Service,$%global_name%Options^);
echo $Options.get^('%vivaldi_selenium_browser_url%'^);
echo #$Options.Navigate^(^).GoToURL^('%vivaldi_selenium_browser_url%'^);
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="bbccookies-continue-button"]/span[1]'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="header-content"]/nav/div[1]/div/div[2]/ul[2]/li[2]/a'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo Start-Sleep -s 2;
echo $pageTitle = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
echo $%global_name%Service.Dispose^(^);
if %close_selenium% == 1 echo $Options.Close^(^);$Options.Quit^(^);
)>"%root_path:"=%%~n0-%global_name%.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" %*
if %debug% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
:skipvivaldi

::Opera
if %opera_selenium% == 0 goto :skipopera
::get opera path since version numbered is dynamic
set operapath=%LocalAppData%\Programs\Opera
set operaversion=nil & if exist "%operapath%" for /D %%X in ("%operapath%\*") do echo %%X|find "." >nul && set operaversion=%%X
::end opera path
set global_name=opera
set global_drver_type=Chrome
::start powershell code
(
if %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path:"=%';
echo Import-Module '%root_path:"=%WebDriver.dll' -Force;
echo Import-Module '%root_path:"=%WebDriver.Support.dll' -Force;
echo Import-Module '%root_path:"=%Selenium.WebDriverBackedSelenium.dll' -Force;
echo $%global_name%Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Options;
echo #https://www.selenium.dev/selenium/docs/api/dotnet/html/T_OpenQA_Selenium_DriverService.htm
echo $%global_name%Service = [OpenQA.Selenium.%global_drver_type%.%global_drver_type%DriverService]::CreateDefaultService^(^);
echo #$%global_name%Service.HideCommandPromptWindow = $true;
echo #$%global_name%Service.SuppressInitialDiagnosticInformation = $true;
echo $%global_name%Service.DriverServiceExecutableName = 'operadriver';
echo Start-Sleep -s 2;
if %headlessbrowser% == 1 echo $%global_name%Options.AddArgument^('--headless'^);
echo #$%global_name%Options.addArgument^("start-maximized"^);
echo #$%global_name%Options.addArgument^("--incognito"^);
echo #$%global_name%Options.EnsureCleanSession = $true;
echo #$%global_name%Options.PageLoadStrategy = 'Normal';
echo #$%global_name%Options.LeaveBrowserRunning = $True;
echo #$%global_name%Options.AcceptInsecureCertificates = $true;
echo $%global_name%Options.BinaryLocation = "%operaversion%\opera.exe";
echo #$%global_name%Options.AddArgument^(^);
echo #$%global_name%Remote = OpenQA.Selenium.Remote.DesiredCapabilities.%global_drver_type%;
echo $Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Driver^($%global_name%Service,$%global_name%Options^);
echo $Options.Navigate^(^).GoToURL^('%opera_selenium_browser_url%'^);
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="bbccookies-continue-button"]/span[1]'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="header-content"]/nav/div[1]/div/div[2]/ul[2]/li[2]/a'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo Start-Sleep -s 2;
echo $pageTitle = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
echo $%global_name%Service.Dispose^(^);
if %close_selenium% == 1 echo $Options.Close^(^);$Options.Quit^(^);
)>"%root_path:"=%%~n0-%global_name%.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" %*
if %debug% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
:skipopera

::TOR Browser
if %tor_selenium% == 0 goto :skiptor
set global_name=tor
set global_drver_type=Firefox
::start powershell code
(
if %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path:"=%';
echo Import-Module '%root_path:"=%WebDriver.dll';
echo Import-Module '%root_path:"=%WebDriver.Support.dll';
echo Import-Module '%root_path:"=%Selenium.WebDriverBackedSelenium.dll';
echo $%global_name%options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Options;
echo #https://www.selenium.dev/selenium/docs/api/dotnet/html/T_OpenQA_Selenium_Firefox_FirefoxDriverService.htm
echo $%global_name%Service = [OpenQA.Selenium.%global_drver_type%.%global_drver_type%DriverService]::CreateDefaultService^(^);
echo #$%global_name%Service.HideCommandPromptWindow = $true;
echo #$%global_name%Service.SuppressInitialDiagnosticInformation = $true;
echo $%global_name%Service.DriverServiceExecutableName = 'geckodriver';
echo $%global_name%Service.FirefoxBinaryPath = 'C:\Users\MEDIA-SERVER\Desktop\Tor Browser\Browser\firefox.exe';
if %headlessbrowser% == 1 echo $%global_name%options.AddArgument^('--headless'^);
echo Write-Output $%global_name%options.CommandLineArguments^(^).get^(^);
echo #$%global_name%options.AddArgument^("--kiosk"^);
echo #$%global_name%options.AddArgument^("--allow-remote"^);
echo $%global_name%options.EnsureCleanSession = $true;
echo $%global_name%options.PageLoadStrategy = 'Normal';
echo $%global_name%options.LeaveBrowserRunning = $True;
echo $%global_name%options.AcceptInsecureCertificates = $true;
echo $%global_name%Options.BinaryLocation = "C:\Users\MEDIA-SERVER\Desktop\Tor Browser\Browser\firefox.exe";
echo $%global_name%options.AddArgument^(^);
echo $Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Driver^($%global_name%Service,$%global_name%options^);
echo $Options.Url^('%tor_selenium_browser_url%'^);
echo $Options.Navigate^(^).GoToURL^('%tor_selenium_browser_url%'^);
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="bbccookies-continue-button"]/span[1]'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="header-content"]/nav/div[1]/div/div[2]/ul[2]/li[2]/a'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo Start-Sleep -s 2;
echo $pageTitle = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
echo $%global_name%Service.Dispose^(^);
if %close_selenium% == 1 echo $Options.Close^(^);$Options.Quit^(^);
)>"%root_path:"=%%~n0-%global_name%.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" %*
if %debug% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
:skiptor

::PhantomJS Browser
if %phantomjs_selenium% == 0 goto :skipphantomjs
set global_name=phantomjs
set global_drver_type=PhantomJS
::start powershell code
(
if %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path:"=%';
echo Import-Module '%root_path:"=%WebDriver.dll';
echo Import-Module '%root_path:"=%WebDriver.Support.dll';
echo Import-Module '%root_path:"=%Selenium.WebDriverBackedSelenium.dll';
echo Write-Output 'phantomjs is running';
echo $%global_name%options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Options;
echo #https://www.selenium.dev/selenium/docs/api/dotnet/html/T_OpenQA_Selenium_Firefox_FirefoxDriverService.htm
echo $%global_name%Service = [OpenQA.Selenium.%global_drver_type%.%global_drver_type%DriverService]::CreateDefaultService^(^);
echo #$%global_name%Service.HideCommandPromptWindow = $true;
echo #$%global_name%Service.SuppressInitialDiagnosticInformation = $true;
echo $%global_name%Service.DriverServiceExecutableName = 'phantomjs';
if %headlessbrowser% == 1 echo $%global_name%options.AddArgument^('--headless'^);
echo Write-Output $%global_name%options.CommandLineArguments^(^).get^(^);
echo #$%global_name%options.AddArgument^("--kiosk"^);
echo #$%global_name%options.AddArgument^("--allow-remote"^);
echo #$%global_name%options.EnsureCleanSession = $true;
echo #$%global_name%options.PageLoadStrategy = 'Normal';
echo #$%global_name%options.LeaveBrowserRunning = $True;
echo #$%global_name%options.AcceptInsecureCertificates = $true;
echo $%global_name%options.AddArgument^(^);
echo $Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Driver^($%global_name%Service,$%global_name%options^);
echo $Options.Url^('%phantomjs_selenium_browser_url%'^);
echo $Options.Navigate^(^).GoToURL^('%phantomjs_selenium_browser_url%'^);
echo $seleniumWait = New-Object -TypeName OpenQA.Selenium.Support.UI.WebDriverWait^($Options, ^(New-TimeSpan -Seconds 10^)^);
echo $seleniumWait.Until^([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementIsVisible^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^)^);
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="bbccookies-continue-button"]/span[1]'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo $seleniumWait = New-Object -TypeName OpenQA.Selenium.Support.UI.WebDriverWait^($Options, ^(New-TimeSpan -Seconds 10^)^);
echo $seleniumWait.Until^([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementIsVisible^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^)^);
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="header-content"]/nav/div[1]/div/div[2]/ul[2]/li[2]/a'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo Start-Sleep -s 2;
echo $seleniumWait = New-Object -TypeName OpenQA.Selenium.Support.UI.WebDriverWait^($Options, ^(New-TimeSpan -Seconds 10^)^);
echo $seleniumWait.Until^([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementIsVisible^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^)^);
echo $pageTitle = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
echo $%global_name%Service.Dispose^(^);
if %close_selenium% == 1 echo $Options.Close^(^);$Options.Quit^(^);
)>"%root_path:"=%%~n0-%global_name%.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" %*
if %debug% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
:skipphantomjs

goto :end_script

goto :next_download
:start_download
set downloadurl=%downloadurl: =%
FOR /f %%i IN ("%downloadurl:"=%") DO set filename="%%~ni"& set fileextension="%%~xi"
set downloadpath="%root_path:"=%%filename%%fileextension%"
(
echo Dim oXMLHTTP
echo Dim oStream
echo Set fso = CreateObject^("Scripting.FileSystemObject"^)
echo If Not fso.FileExists^("%downloadpath:"=%"^) Then
echo Set oXMLHTTP = CreateObject^("MSXML2.ServerXMLHTTP.6.0"^)
echo oXMLHTTP.Open "GET", "%downloadurl:"=%", False
echo oXMLHTTP.SetRequestHeader "User-Agent", "Mozilla/5.0 ^(Windows NT 10.0; Win64; rv:51.0^) Gecko/20100101 Firefox/51.0"
echo oXMLHTTP.SetRequestHeader "Referer", "https://www.google.co.uk/"
echo oXMLHTTP.SetRequestHeader "DNT", "1"
echo oXMLHTTP.Send
echo If oXMLHTTP.Status = 200 Then
echo Set oStream = CreateObject^("ADODB.Stream"^)
echo oStream.Open
echo oStream.Type = 1
echo oStream.Write oXMLHTTP.responseBody
echo oStream.SaveToFile "%downloadpath:"=%"
echo oStream.Close
echo End If
echo End If
echo ZipFile="%downloadpath:"=%"
echo ExtractTo="%root_path:"=%"
echo ext = LCase^(fso.GetExtensionName^(ZipFile^)^)
echo If NOT fso.FolderExists^(ExtractTo^) Then
echo fso.CreateFolder^(ExtractTo^)
echo End If
echo Set app = CreateObject^("Shell.Application"^)
echo Sub ExtractByExtension^(fldr, ext, dst^)
echo For Each f In fldr.Items
echo If f.Type = "File folder" Then
echo ExtractByExtension f.GetFolder, ext, dst
echo End If
echo If instr^(f.Path, "\%file_name_to_extract%"^) ^> 0 Then
echo If fso.FileExists^(dst ^& f.Name ^& "." ^& LCase^(fso.GetExtensionName^(f.Path^)^) ^) Then
echo Else
echo call app.NameSpace^(dst^).CopyHere^(f.Path^, 4^+16^)
echo End If
echo End If
echo Next
echo End Sub
echo If instr^(ZipFile, "zip"^) ^> 0 Then
echo ExtractByExtension app.NameSpace^(ZipFile^), "exe", ExtractTo
echo End If
if %delete_download% == 1 echo fso.DeleteFile ZipFile
echo Set fso = Nothing
echo Set objShell = Nothing
)>"%root_path:"=%%~n0.vbs"
cscript //nologo "%root_path:"=%%~n0.vbs"
if %debug% == 0 del "%root_path:"=%%~n0.vbs"
:next_download

::https://www.selenium.dev/documentation/webdriver/browsers/

::download the internet explorer portable instance
if %internetexplorer_selenium% == 1 (
	if not defined IEDriverServer_exe (
		set downloadurl=https://github.com/SeleniumHQ/selenium/releases/download/selenium-4.6.0/IEDriverServer_x64_4.6.0.zip
		if %PROCESSOR_ARCHITECTURE%==x86 (
			set downloadurl=https://github.com/SeleniumHQ/selenium/releases/download/selenium-4.6.0/IEDriverServer_Win32_4.6.0.zip
		)
		set file_name_to_extract=IEDriverServer.exe
		set delete_download=1
		set IEDriverServer_exe=true
		goto :start_download
	)
)

::download the microsoft edge
if %microsoftedge_selenium% == 1 (
	::microsoft edge driver
	if not defined msedgedriver_exe (
		set downloadurl=https://msedgedriver.azureedge.net/107.0.1418.42/edgedriver_win64.zip
		if %PROCESSOR_ARCHITECTURE%==x86 (
			set downloadurl=https://msedgedriver.azureedge.net/107.0.1418.42/edgedriver_win32.zip
		)
		set file_name_to_extract=msedgedriver.exe
		set delete_download=1
		set msedgedriver_exe=true
		goto :start_download
	)
)

set chromedriver_needed=0
if %chrome_selenium% == 1 set chromedriver_needed=1
if %opera_selenium% == 1 set chromedriver_needed=1
if %vivaldi_selenium% == 1 set chromedriver_needed=1
if %brave_selenium% == 1 set chromedriver_needed=1
if %chromedriver_needed% == 1 (
	::download the google chrome portable instance
	if not defined chromedriver_exe (
		::only 32bit windows available chromedriver ?
		set downloadurl=https://chromedriver.storage.googleapis.com/107.0.5304.18/chromedriver_win32.zip
		set file_name_to_extract=chromedriver.exe
		set delete_download=1
		set chromedriver_exe=true
		goto :start_download
	)
)

set firefoxdriver_needed=0
if %firefox_selenium% == 1 set firefoxdriver_needed=1
if %tor_selenium% == 1 set firefoxdriver_needed=1
if %firefoxdriver_needed% == 1 (
	::download the mozilla firefox webdriver portable instance
	if not defined geckodriver_exe (
		set downloadurl=https://github.com/mozilla/geckodriver/releases/download/v0.32.0/geckodriver-v0.32.0-win64.zip
		if %PROCESSOR_ARCHITECTURE%==x86 (
			set downloadurl=https://github.com/mozilla/geckodriver/releases/download/v0.32.0/geckodriver-v0.32.0-win32.zip
		)
		set file_name_to_extract=geckodriver.exe
		set delete_download=1
		set geckodriver_exe=true
		goto :start_download
	)
)

if %opera_selenium% == 1 (
	::download the opera webdriver portable instance
	if not defined operadriver_exe (
		set downloadurl=https://github.com/operasoftware/operachromiumdriver/releases/download/v.107.0.5304.88/operadriver_win64.zip
		if %PROCESSOR_ARCHITECTURE%==x86 (
			set downloadurl=https://github.com/operasoftware/operachromiumdriver/releases/download/v.107.0.5304.88/operadriver_win32.zip
		)
		set file_name_to_extract=operadriver.exe
		set delete_download=1
		set operadriver_exe=true
		goto :start_download
	)
)

if %phantomjs_selenium% == 1 (
	::download the phantomjs webdriver portable instance
	if not defined phantomjs_exe (
		set downloadurl=https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-windows.zip
		set file_name_to_extract=phantomjs.exe
		set delete_download=1
		set phantomjs_exe=true
		goto :start_download
	)
)

::get netframework installed version to extract the right .dll file that will be compatible
set alias=REG QUERY ^"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP^"
for /f "tokens=*" %%a in ('
%alias% /s ^| FIND ^"Version^" 2^>Nul
') do (
set framework_version=%%a
::set "framework_version=!framework_version:~1,-1!"
set "framework_version=!framework_version:.=!"
set "framework_version=!framework_version: =!"
set "framework_version=!framework_version:Version=!"
set "framework_version=!framework_version:Target=!"
set "framework_version=!framework_version:REG_SZ=!"
if !framework_version! gtr 2000000 set net_framework=netstandard2.0
if !framework_version! gtr 2100000 set net_framework=netstandard2.1
if !framework_version! gtr 4500000 set net_framework=net45
if !framework_version! gtr 4600000 set net_framework=net46
if !framework_version! gtr 4700000 set net_framework=net47
if !framework_version! gtr 4800000 set net_framework=net48
if !framework_version! gtr 5000000 set net_framework=net5.0
)
::end netframework check

::download selenium
if not defined webdriver_dll (
	set downloadurl=https://globalcdn.nuget.org/packages/selenium.webdriver.4.6.0.nupkg
	set delete_download=0
	set webdriver_dll=true
	goto :start_download
)
::selenium by default is a nupkg its a renamed zip file lets make it a zip again so we can extract the dynamic library file we need.
if not defined webdriver_zip (
	rename "%downloadpath:"=%" "%filename:"=%.zip"
	set downloadurl="%root_path:"=%selenium.webdriver.4.6.0.zip"
	set file_name_to_extract=lib\%net_framework%\WebDriver.dll
	set delete_download=1
	set webdriver_zip=true
	goto :start_download
)
::download selenium support driver dll
if not defined webdriver_support_dll (
	set downloadurl=https://globalcdn.nuget.org/packages/selenium.support.4.6.0.nupkg
	set delete_download=0
	set webdriver_support_dll=true
	goto :start_download
)
::selenium by default is a nupkg its a renamed zip file lets make it a zip again so we can extract the dynamic library file we need.
if not defined webdriver_support_zip (
	rename "%downloadpath:"=%" "%filename:"=%.zip"
	set downloadurl="%root_path:"=%selenium.support.4.6.0.zip"
	set file_name_to_extract=lib\%net_framework%\WebDriver.Support.dll
	set delete_download=1
	set webdriver_support_zip=true
	goto :start_download
)
::download selenium backdated support driver dll
if not defined webdriver_backed_support_dll (
	set downloadurl=https://globalcdn.nuget.org/packages/selenium.webdriverbackedselenium.4.1.0.nupkg
	set delete_download=0
	set webdriver_backed_support_dll=true
	goto :start_download
)
::selenium by default is a nupkg its a renamed zip file lets make it a zip again so we can extract the dynamic library file we need.
if not defined webdriver_backed_zip (
	rename "%downloadpath:"=%" "%filename:"=%.zip"
	set downloadurl="%root_path:"=%selenium.webdriverbackedselenium.4.1.0.zip"
	set file_name_to_extract=lib\%net_framework%\Selenium.WebDriverBackedSelenium.dll
	set delete_download=1
	set webdriver_backed_zip=true
	goto :start_download
)

::firefox browser downloads
if %firefox_selenium% == 1 (
	if not exist "%programs_path%\Mozilla Firefox\firefox.exe" (
		if not defined firefoxinstaller_exe (
			set downloadurl=https://ftp.mozilla.org/pub/firefox/releases/107.0/win64/en-GB/Firefox%%20Setup%%20107.0.msi
			if %PROCESSOR_ARCHITECTURE%==x86 (
				set downloadurl=https://ftp.mozilla.org/pub/firefox/releases/107.0/win32/en-GB/Firefox%%20Setup%%20107.0.msi
			)
			set file_name_to_extract=firefox.msi
			set delete_download=0
			set firefoxinstaller_exe=true
			::my little trick for redirects and links that dont have a file name i will create one
			set downloadurl=!downloadurl!^?#/!file_name_to_extract!
			goto :start_download
		) else (
			call "%windir%\%system_folder%\msiexec.exe" /fa "%root_path:"=%%filename:"=%%fileextension:"=%" /qn
			call "%windir%\%system_folder%\msiexec.exe" /i "%root_path:"=%%filename:"=%%fileextension:"=%" /qn
		)
	)
)

::chrome browser downloads
if %chrome_selenium% == 1 (
	if not exist "%programs_path%\Google\Chrome\Application\chrome.exe" (
		if not defined chromeinstaller_exe (
			set downloadurl=https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi
			if %PROCESSOR_ARCHITECTURE%==x86 (
				set downloadurl=https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise.msi
			)
			set file_name_to_extract=googlechromestandaloneenterprise.msi
			set delete_download=0
			set chromeinstaller_exe=true
			::my little trick for redirects and links that dont have a file name i will create one
			set downloadurl=!downloadurl!^?#/!file_name_to_extract!
			goto :start_download
		) else (
			call "%windir%\%system_folder%\msiexec.exe" /fa "%root_path:"=%%filename:"=%%fileextension:"=%" /qn
			call "%windir%\%system_folder%\msiexec.exe" /i "%root_path:"=%%filename:"=%%fileextension:"=%" /qn
		)
	)
)

::safari is no longer maintained for windows by apple good ridance worst browser even on iphones!

::download the microsoft edge
if %microsoftedge_selenium% == 1 (
	::https://techcommunity.microsoft.com/t5/discussions/official-download-links-for-microsoft-edge-stable-enterprise/m-p/1082549
	::for some reason even 64bit edge by default is installed to the 32bit programs directory blame microsoft
	if not exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
		if not defined microsoftedge_exe (
			set downloadurl=http://go.microsoft.com/fwlink/^?LinkID=2093437
			if %PROCESSOR_ARCHITECTURE%==x86 (
				set downloadurl=http://go.microsoft.com/fwlink/^?LinkID=2093505
			)
			set file_name_to_extract=microsoftedge.msi
			set delete_download=0
			set microsoftedge_exe=true
			::my little trick for redirects and links that dont have a file name i will create one
			::do not need a query string ? arg on this because the url already has one
			set downloadurl=!downloadurl!#/!file_name_to_extract!
			goto :start_download
		) else (
			::unusual for a windows system to not have edge but just incase we will repair the install incase deleted
			call "%windir%\%system_folder%\msiexec.exe" /fa "%root_path:"=%%filename:"=%%fileextension:"=%" /qn
			call "%windir%\%system_folder%\msiexec.exe" /i "%root_path:"=%%filename:"=%%fileextension:"=%" /qn
		)
	)
)

::brave browser downloads
if %brave_selenium% == 1 (
	if not exist "%LocalAppData%\BraveSoftware\Brave-Browser-Nightly\Application\brave.exe" (
		if not defined braveinstaller_exe (
			set downloadurl=https://github.com/brave/brave-browser/releases/latest/download/BraveBrowserStandaloneSilentNightlySetup.exe
			if %PROCESSOR_ARCHITECTURE%==x86 (
				set downloadurl=https://github.com/brave/brave-browser/releases/latest/download/BraveBrowserStandaloneSilentNightlySetup32.exe
			)
			set file_name_to_extract=BraveInstaller.exe
			set delete_download=0
			set braveinstaller_exe=true
			::my little trick for redirects and links that dont have a file name i will create one
			set downloadurl=!downloadurl!^?#/!file_name_to_extract!
			goto :start_download
		) else (
			call "%root_path:"=%%filename:"=%%fileextension:"=%"
		)
	)
)

::get opera path since version numbered is dynamic
set operapath=%LocalAppData%\Programs\Opera
set operaversion=nil & if exist "%operapath%" for /D %%X in ("%operapath%\*") do echo %%X|find "." >nul && set operaversion=%%X
::end opera path
::opera browser downloads
if %opera_selenium% == 1 (
	if not exist "%operaversion%\opera.exe" (
		if not defined operainstaller_exe (
			set downloadurl=https://net.geo.opera.com/opera/stable/windows
			set file_name_to_extract=OperaInstaller.exe
			set delete_download=0
			set operainstaller_exe=true
			::my little trick for redirects and links that dont have a file name i will create one
			set downloadurl=!downloadurl!^?#/!file_name_to_extract!
			goto :start_download
		) else (
			call "%root_path:"=%%filename:"=%%fileextension:"=%" /silent /allusers=0 /launchopera=0 /setdefaultbrowser=0
		)
	)
)

::vivaldi browser downloads
if %vivaldi_selenium% == 1 (
	if not exist "%LocalAppData%\Vivaldi\Application\vivaldi.exe" (
		if not defined vivaldiinstaller_exe (
			set downloadurl=https://downloads.vivaldi.com/stable/Vivaldi.5.5.2805.44.x64.exe
			if %PROCESSOR_ARCHITECTURE%==x86 (
				set downloadurl=https://downloads.vivaldi.com/stable/Vivaldi.5.5.2805.44.exe
			)
			set file_name_to_extract=VivaldiInstaller.exe
			set delete_download=0
			set vivaldiinstaller_exe=true
			::my little trick for redirects and links that dont have a file name i will create one
			set downloadurl=!downloadurl!^?#/!file_name_to_extract!
			goto :start_download
		) else (
			call "%root_path:"=%%filename:"=%%fileextension:"=%" --vivaldi-silent --do-not-launch-chrome
		)
	)
)

::Tor browser downloads
if %tor_selenium% == 1 (
	if not exist "%userprofile%\Desktop\Tor Browser\Browser\firefox.exe" (
		if not defined torinstaller_exe (
			set downloadurl=https://www.torproject.org/dist/torbrowser/11.5.7/torbrowser-install-win64-11.5.7_en-US.exe
			if %PROCESSOR_ARCHITECTURE%==x86 (
				set downloadurl=https://www.torproject.org/dist/torbrowser/11.5.7/torbrowser-install-11.5.7_en-US.exe
			)
			set file_name_to_extract=TorInstaller.exe
			set delete_download=0
			set torinstaller_exe=true
			goto :start_download
		) else (
			call "%root_path:"=%%filename:"=%%fileextension:"=%" /S
		)
	)
)

::for files that are not zip and renaming them would not do any good we can use winrar for
::dont worry i wrote the code so we make sure its installed first if not will download and add it to the system for user
::if not exist "%programs_path%\WinRAR\winrar.exe" (
::	if not defined winrar_exe (
::		set downloadurl=https://www.rarlab.com/rar/winrar-x64-620b2.exe
::		if %PROCESSOR_ARCHITECTURE%==x86 (
::			set downloadurl=https://www.rarlab.com/rar/winrar-x32-620b2.exe
::		)
::		set delete_download=0
::		set winrar_exe=true
::		goto :start_download
::	)
::	call "%downloadpath%" /s
::	del "%downloadpath%"
::) else (
::	call ^"%programs_path%\WinRAR\unrar.exe^" x ^"%downloadpath%^" ^"lib\net48\webdriver.dll^" ^"%root_path:"=%^"
::)

goto :start_exe
:end_script

if %cleanup% == 0 goto :skipcleanup
	::Webdriver cleanup
	if exist "%root_path:"=%IEDriverServer.exe" (
		for /f "tokens=*" %%a in ('
			taskkill /F /IM IEDriverServer.exe /T 2^>Nul
		') do break
		del "%root_path:"=%IEDriverServer.exe"
	)
	if exist "%root_path:"=%msedgedriver.exe" (
		for /f "tokens=*" %%a in ('
			taskkill /F /IM msedgedriver.exe /T 2^>Nul
		') do break
		del "%root_path:"=%msedgedriver.exe"
	)
	if exist "%root_path:"=%chromedriver.exe" (
		for /f "tokens=*" %%a in ('
			taskkill /F /IM chromedriver.exe /T 2^>Nul
		') do break
		del "%root_path:"=%chromedriver.exe"
	)
	if exist "%root_path:"=%geckodriver.exe" (
		for /f "tokens=*" %%a in ('
			taskkill /F /IM geckodriver.exe /T 2^>Nul
		') do break
		del "%root_path:"=%geckodriver.exe"
	)
	if exist "%root_path:"=%operadriver.exe" (
		for /f "tokens=*" %%a in ('
			taskkill /F /IM operadriver.exe /T 2^>Nul
		') do break
		del "%root_path:"=%operadriver.exe"
	)
	if exist "%root_path:"=%phantomjs.exe" (
		for /f "tokens=*" %%a in ('
			taskkill /F /IM phantomjs.exe /T 2^>Nul
		') do break
		del "%root_path:"=%phantomjs.exe"
	)
	::End Webdriver cleanup

	::Install browser cleanup
	if exist "%root_path:"=%firefox.msi" (
		del "%root_path:"=%firefox.msi"
	)
	if exist "%root_path:"=%microsoftedge.msi" (
		del "%root_path:"=%microsoftedge.msi"
	)
	if exist "%root_path:"=%googlechromestandaloneenterprise.msi" (
		del "%root_path:"=%googlechromestandaloneenterprise.msi"
	)
	if exist "%root_path:"=%TorInstaller.exe" (
		del "%root_path:"=%TorInstaller.exe"
	)
	if exist "%root_path:"=%VivaldiInstaller.exe" (
		del "%root_path:"=%VivaldiInstaller.exe"
	)
	if exist "%root_path:"=%OperaInstaller.exe" (
		del "%root_path:"=%OperaInstaller.exe"
	)
	if exist "%root_path:"=%BraveInstaller.exe" (
		del "%root_path:"=%BraveInstaller.exe"
	)
	::End Install browser cleanup

	::Selenium cleanup
	if exist "%root_path:"=%WebDriver.dll" (
		del "%root_path:"=%WebDriver.dll"
	)
	if exist "%root_path:"=%WebDriver.Support.dll" (
		del "%root_path:"=%WebDriver.Support.dll"
	)
	if exist "%root_path:"=%Selenium.WebDriverBackedSelenium.dll" (
		del "%root_path:"=%Selenium.WebDriverBackedSelenium.dll"
	)
	::End Selenium cleanup
:skipcleanup

if %pause_window% == 1 pause

timeout /t %schedule% >nul

exit
