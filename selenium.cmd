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
set microsoftedge_selenium=0

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
set vivaldi_selenium=1

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

::Tor Bridge to use for encrypted traffic
::1 obfs4 - obfs4 is a type of built-in bridge that makes your Tor traffic look random. They are also less likely to be blocked than their predecessors, obfs3 bridges.
::2 snowflake - Snowflake is a built-in bridge that defeats censorship by routing your connection through Snowflake proxies, ran by volunteers.
::3 meek-azure - meek-azure is a built-in bridge that makes it look like you are using a Microsoft web site instead of using Tor.
set tor_proxy_bridge=1

::the webpage we want to access to perform a remote automated task on for Tor
set tor_selenium_browser_url=https://www.bbc.co.uk/

::PhantomJS selenium browser
:: 1 enabled
:: 0 disabled
set phantomjs_selenium=1

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
set cleanup=0

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
::example inside the directory with this batch file you will see a file left every run called chrome.ps1 or firefox.ps1 modify this for your needs
::it wont be deleted and each run time of this batch file it will use this file instead of the inline code in this batch file
:: means you do not need to edit the batch file you can focus on your selenium script modifications without needing to escape batch code
:: 1 enabled
:: 0 disabled
set custom_selenium_script=1

::Set custom user-agent to use if you do not want to expose your default selenium browser user-agent
set custom_user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36 Edg/107.0.1418.52"

::Patch chromedriver.exe and msedgedriver.exe changing the identifiable cdc_* string that services like cloudflare and such use to identify selenium
:: 1 enabled
:: 0 disabled
set selenium_driver_patches=0

:: End Edit DO NOT TOUCH ANYTHING BELOW THIS POINT UNLESS YOU KNOW WHAT YOUR DOING!

TITLE C0nw0nk - Selenium - github.com/C0nw0nk/Selenium

if defined varpass goto :start_exe

set root_path="%~dp0"

set site=https://chromedriver.storage.googleapis.com/LATEST_RELEASE

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
if %custom_selenium_script% == 0 goto :start_ie
if not exist "%root_path:"=%%~n0-%global_name%.ps1" goto :start_ie
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
goto :skipie
:start_ie
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
echo #https://www.selenium.dev/selenium/docs/api/dotnet/html/T_OpenQA_Selenium_IE_InternetExplorerDriverService.htm
echo $%global_name%Service = [OpenQA.Selenium.%global_drver_type%.%global_drver_type_name%DriverService]::CreateDefaultService^('%root_path:"=%','IEDriverServer.exe'^);
echo #$%global_name%Service.HideCommandPromptWindow = $true;
echo #$%global_name%Service.SuppressInitialDiagnosticInformation = $true;
if %headlessbrowser% == 1 echo $%global_name%Options.addArgument^('--headless'^);
echo $%global_name%Options.addArgument^("-inprivate"^);
echo $%global_name%Options.IgnoreZoomLevel = $true;
echo $%global_name%Options.PageLoadStrategy = 'Normal';
echo $%global_name%Options.UnexpectedAlertBehavior = 'ignore';
echo $%global_name%Options.IntroduceInstabilityByIgnoringProtectedModeSettings = $true;
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
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
if %debug% == 0 if %custom_selenium_script% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
:skipie

::Microsoft Edge
if %microsoftedge_selenium% == 0 goto :skipedge
set global_name=edge
set global_drver_type=Edge
if %custom_selenium_script% == 0 goto :start_edge
if not exist "%root_path:"=%%~n0-%global_name%.ps1" goto :start_edge
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
goto :skipedge
:start_edge
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
echo $%global_name%Service = [OpenQA.Selenium.%global_drver_type%.%global_drver_type%DriverService]::CreateDefaultService^('%root_path:"=%','msedgedriver.exe'^);
echo $%global_name%Service.HideCommandPromptWindow = $true;
echo $%global_name%Service.SuppressInitialDiagnosticInformation = $true;
if %headlessbrowser% == 1 echo $%global_name%Options.addArgument^('--headless'^);
echo $%global_name%Options.addArgument^("start-maximized"^);
echo #$%global_name%Options.addArgument^("-inprivate"^);
echo $%global_name%Options.addExperimentalOption^("useAutomationExtension", $false^);
echo $%global_name%Options.AddAdditionalCapability^('w3c', $false^);
echo $UserAgent = %custom_user_agent%;
echo $%global_name%Options.addArgument^("user-agent=$UserAgent"^);
echo #$%global_name%Options.addArgument^("--window-size=1920,1080"^);
echo $%global_name%Options.PageLoadStrategy = 'Normal';
echo $%global_name%Options.LeaveBrowserRunning = $true;
echo $%global_name%Options.AcceptInsecureCertificates = $true;
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
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
if %debug% == 0 if %custom_selenium_script% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
:skipedge

::Chrome
if %chrome_selenium% == 0 goto :skipchrome
set global_name=chrome
set global_drver_type=Chrome
if %custom_selenium_script% == 0 goto :start_chrome
if not exist "%root_path:"=%%~n0-%global_name%.ps1" goto :start_chrome
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
goto :skipchrome
:start_chrome
::start powershell code
(
if %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path:"=%';
echo Import-Module '%root_path:"=%WebDriver.dll';
echo Import-Module '%root_path:"=%WebDriver.Support.dll';
echo Import-Module '%root_path:"=%Selenium.WebDriverBackedSelenium.dll';
echo $%global_name%Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Options;
echo #https://www.selenium.dev/selenium/docs/api/dotnet/html/T_OpenQA_Selenium_DriverService.htm
echo $%global_name%Service = [OpenQA.Selenium.%global_drver_type%.%global_drver_type%DriverService]::CreateDefaultService^('%root_path:"=%','chromedriver.exe'^);
echo $%global_name%Service.HideCommandPromptWindow = $true;
echo $%global_name%Service.SuppressInitialDiagnosticInformation = $true;
if %headlessbrowser% == 1 echo $%global_name%Options.addArgument^('--headless'^);
echo $%global_name%Options.addArgument^("start-maximized"^);
echo $%global_name%Options.addArgument^("--incognito"^);
echo $%global_name%Options.addArgument^("--disable-blink-features=AutomationControlled"^);
echo $UserAgent = %custom_user_agent%;
echo $%global_name%Options.addArgument^("user-agent=$UserAgent"^);
echo $%global_name%Options.addArgument^("--window-size=1920,1080"^);
echo $%global_name%Options.PageLoadStrategy = 'Normal';
echo $%global_name%Options.LeaveBrowserRunning = $true;
echo $%global_name%Options.AcceptInsecureCertificates = $true;
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
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
if %debug% == 0 if %custom_selenium_script% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
:skipchrome

::Firefox
if %firefox_selenium% == 0 goto :skipfirefox
set global_name=firefox
set global_drver_type=Firefox
if %custom_selenium_script% == 0 goto :start_firefox
if not exist "%root_path:"=%%~n0-%global_name%.ps1" goto :start_firefox
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
goto :skipfirefox
:start_firefox
::start powershell code
(
if %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path:"=%';
echo Import-Module '%root_path:"=%WebDriver.dll';
echo Import-Module '%root_path:"=%WebDriver.Support.dll';
echo Import-Module '%root_path:"=%Selenium.WebDriverBackedSelenium.dll';
echo $%global_name%Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Options;
echo #https://www.selenium.dev/selenium/docs/api/dotnet/html/T_OpenQA_Selenium_Firefox_FirefoxDriverService.htm
echo $%global_name%Service = [OpenQA.Selenium.%global_drver_type%.%global_drver_type%DriverService]::CreateDefaultService^('%root_path:"=%','geckodriver.exe'^);
echo $%global_name%Service.HideCommandPromptWindow = $true;
echo $%global_name%Service.SuppressInitialDiagnosticInformation = $true;
if %headlessbrowser% == 1 echo $%global_name%Options.addArgument^('--headless'^);
echo #$%global_name%Options.addArgument^("--kiosk"^);
echo $%global_name%Options.addArgument^("--private-window"^);
echo $UserAgent = %custom_user_agent%;
echo #$%global_name%Options.addArgument^("user-agent=$UserAgent"^);
echo #$%global_name%Options.addArgument^("--window-size=1920,1080"^);
echo $%global_name%Options.addArgument^("--height=600"^);
echo $%global_name%Options.addArgument^("--width=600"^);
echo $%global_name%Options.setPreference^("general.useragent.override", "$UserAgent"^);
echo $%global_name%Options.PageLoadStrategy = 'Normal';
echo $%global_name%Options.LeaveBrowserRunning = $true;
echo $%global_name%Options.AcceptInsecureCertificates = $true;
echo $Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Driver^($%global_name%Service,$%global_name%Options^);
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
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
if %debug% == 0 if %custom_selenium_script% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
:skipfirefox

::Brave
if %brave_selenium% == 0 goto :skipbrave
set global_name=brave
set global_drver_type=Chrome
if %custom_selenium_script% == 0 goto :start_brave
if not exist "%root_path:"=%%~n0-%global_name%.ps1" goto :start_brave
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
goto :skipbrave
:start_brave
::start powershell code
(
if %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path:"=%';
echo Import-Module '%root_path:"=%WebDriver.dll';
echo Import-Module '%root_path:"=%WebDriver.Support.dll';
echo Import-Module '%root_path:"=%Selenium.WebDriverBackedSelenium.dll';
echo $%global_name%Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Options;
echo #https://www.selenium.dev/selenium/docs/api/dotnet/html/T_OpenQA_Selenium_DriverService.htm
echo $%global_name%Service = [OpenQA.Selenium.%global_drver_type%.%global_drver_type%DriverService]::CreateDefaultService^('%root_path:"=%','chromedriver.exe'^);
echo $%global_name%Service.HideCommandPromptWindow = $true;
echo $%global_name%Service.SuppressInitialDiagnosticInformation = $true;
if %headlessbrowser% == 1 echo $%global_name%Options.addArgument^('--headless'^);
echo $%global_name%Options.addArgument^("start-maximized"^);
echo $%global_name%Options.addArgument^("--incognito"^);
echo $%global_name%Options.addArgument^("--disable-blink-features=AutomationControlled"^);
echo $UserAgent = %custom_user_agent%;
echo $%global_name%Options.addArgument^("user-agent=$UserAgent"^);
echo $%global_name%Options.addArgument^("--window-size=1920,1080"^);
echo $%global_name%Options.PageLoadStrategy = 'Normal';
echo $%global_name%Options.LeaveBrowserRunning = $true;
echo $%global_name%Options.AcceptInsecureCertificates = $true;
echo $%global_name%Options.BinaryLocation = "%LocalAppData%\BraveSoftware\Brave-Browser\Application\brave.exe";
echo $Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Driver^($%global_name%Service,$%global_name%Options^);
echo #$Options.executeScript^("Object.defineProperty^(navigator, 'webdriver', ^{set: ^(^) => undefined^}^)"^);
echo $Options.Navigate^(^).GoToURL^('%brave_selenium_browser_url%'^);
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="bbccookies-continue-button"]/span[1]'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="header-content"]/nav/div[1]/div/div[2]/ul[2]/li[2]/a'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo Start-Sleep -s 2;
echo $pageTitle = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo $driver_script = $Options.executeScript^("return navigator.webdriver"^);
echo Write-Output $driver_script;
echo Write-Output $pageTitle;
echo $%global_name%Service.Dispose^(^);
if %close_selenium% == 1 echo $Options.Close^(^);$Options.Quit^(^);
)>"%root_path:"=%%~n0-%global_name%.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
if %debug% == 0 if %custom_selenium_script% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
:skipbrave

::Vivaldi
if %vivaldi_selenium% == 0 goto :skipvivaldi
set global_name=vivaldi
set global_drver_type=Chrome
if %custom_selenium_script% == 0 goto :start_vivaldi
if not exist "%root_path:"=%%~n0-%global_name%.ps1" goto :start_vivaldi
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
goto :skipvivaldi
:start_vivaldi
::start powershell code
(
if %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path:"=%';
echo Import-Module '%root_path:"=%WebDriver.dll';
echo Import-Module '%root_path:"=%WebDriver.Support.dll';
echo Import-Module '%root_path:"=%Selenium.WebDriverBackedSelenium.dll';
echo $%global_name%Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Options;
echo #https://www.selenium.dev/selenium/docs/api/dotnet/html/T_OpenQA_Selenium_DriverService.htm
echo $%global_name%Service = [OpenQA.Selenium.%global_drver_type%.%global_drver_type%DriverService]::CreateDefaultService^('%root_path:"=%','vivaldichromedriver.exe'^);
echo $%global_name%Service.HideCommandPromptWindow = $true;
echo $%global_name%Service.SuppressInitialDiagnosticInformation = $true;
if %headlessbrowser% == 1 echo $%global_name%Options.addArgument^('--headless'^);
echo $%global_name%Options.addArgument^("start-maximized"^);
echo $%global_name%Options.addArgument^("--incognito"^);
echo $%global_name%Options.addArgument^("--disable-blink-features=AutomationControlled"^);
echo #$%global_name%Options.addArgument^("--user-data-dir='%LocalAppData%\Vivaldi\User Data'"^);
echo $%global_name%Options.PageLoadStrategy = 'Normal';
echo $%global_name%Options.LeaveBrowserRunning = $true;
echo $%global_name%Options.AcceptInsecureCertificates = $true;
echo #$%global_name%Options.BinaryLocation = "%LocalAppData%\Vivaldi\Application\update_notifier.exe";
echo $%global_name%Options.BinaryLocation = "%LocalAppData%\Vivaldi\Application\vivaldi.exe";
echo #$%global_name%Options.BinaryLocation = "%LocalAppData%\Vivaldi\Application\vivaldi_proxy.exe";
echo #$%global_name%Options.Profile = "%LocalAppData%\Vivaldi\User Data\Default";
echo #$%global_name%Options.setPreference^("--user-data-dir=%LocalAppData%\Vivaldi\User Data"^);
echo $Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Driver^($%global_name%Service,$%global_name%Options^);
echo $timeout = 10;
echo [OpenQA.Selenium.Support.UI.WebDriverWait]$wait = new-object OpenQA.Selenium.Support.UI.WebDriverWait ^($Options,[System.TimeSpan]::FromSeconds^($timeout^)^);
echo [OpenQA.Selenium.Interactions.Actions]$actions = new-object OpenQA.Selenium.Interactions.Actions ^($Options^);
echo $Options.Navigate^(^).GoToURL^('%vivaldi_selenium_browser_url%'^);
echo $wait.Until^([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementExists^([OpenQA.Selenium.By]::tagname^('title'^)^)^);
echo $pageTitle = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
echo $%global_name%Service.Dispose^(^);
if %close_selenium% == 1 echo $Options.Close^(^);$Options.Quit^(^);
)>"%root_path:"=%%~n0-%global_name%.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
if %debug% == 0 if %custom_selenium_script% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
:skipvivaldi

::Opera
if %opera_selenium% == 0 goto :skipopera
::get opera path since version numbered is dynamic
set operapath=%LocalAppData%\Programs\Opera
set operaversion=nil & if exist "%operapath%" for /D %%X in ("%operapath%\*") do echo %%X|find "." >nul && set operaversion=%%X
::end opera path
set global_name=opera
set global_drver_type=Chrome
if %custom_selenium_script% == 0 goto :start_opera
if not exist "%root_path:"=%%~n0-%global_name%.ps1" goto :start_opera
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
goto :skipopera
:start_opera
::start powershell code
(
if %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path:"=%';
echo Import-Module '%root_path:"=%WebDriver.dll';
echo Import-Module '%root_path:"=%WebDriver.Support.dll';
echo Import-Module '%root_path:"=%Selenium.WebDriverBackedSelenium.dll';
echo $%global_name%Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Options;
echo #https://www.selenium.dev/selenium/docs/api/dotnet/html/T_OpenQA_Selenium_DriverService.htm
echo $%global_name%Service = [OpenQA.Selenium.%global_drver_type%.%global_drver_type%DriverService]::CreateDefaultService^('%root_path:"=%','operadriver.exe'^);
echo $%global_name%Service.HideCommandPromptWindow = $true;
echo $%global_name%Service.SuppressInitialDiagnosticInformation = $true;
if %headlessbrowser% == 1 echo $%global_name%Options.addArgument^('--headless'^);
echo $%global_name%Options.BinaryLocation = "%operaversion%\opera.exe";
echo #$%global_name%Options.BinaryLocation = "%LocalAppData%\Programs\Opera\launcher.exe";
echo $%global_name%Options.addExperimentalOption^('w3c', $true^);
echo $%global_name%Options.AddAdditionalCapability^('w3c', $true^);
echo $Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Driver^($%global_name%Service,$%global_name%Options^);
echo #$webData = Invoke-WebRequest -Uri "http://127.0.0.1:9222/json/version";
echo #$releases = ConvertFrom-Json $webData.content;
echo #write-output $releases.webSocketDebuggerUrl;
echo $Options.Navigate^(^).GoToURL^('%opera_selenium_browser_url%'^);
echo #$pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="bbccookies-continue-button"]/span[1]'^)^);
echo #$pageData.Click^(^);
echo #$pageData.Url^(^); #this will navigate browser to the clicked element
echo #$pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="header-content"]/nav/div[1]/div/div[2]/ul[2]/li[2]/a'^)^);
echo #$pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo #Start-Sleep -s 2;
echo $pageTitle = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
echo $%global_name%Service.Dispose^(^);
if %close_selenium% == 1 echo $Options.Close^(^);$Options.Quit^(^);
)>"%root_path:"=%%~n0-%global_name%.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
if %debug% == 0 if %custom_selenium_script% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
:skipopera

::TOR Browser
if %tor_selenium% == 0 goto :skiptor
set global_name=tor
set global_drver_type=Firefox
::higher security keeping the tor.exe encryption secure I made it a setting for debugging reasons when i built this
set tor_proxy_password_enabled=1
(
echo function Get-RandomCharacters^($length, $characters^) { 
echo $random = 1..$length ^| ForEach-Object { Get-Random -Maximum $characters.length } 
echo $private:ofs="" ;
echo return [String]$characters[$random];
echo }
echo $randompass ^+= Get-RandomCharacters -length 20 -characters 'ABCDEFGHKLMNOPRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
echo Write-Output $randompass;
)>"%root_path:"=%%~n0-%global_name%-generate-random-pass.ps1"
for /f "tokens=*" %%a in ('
powershell -ExecutionPolicy Unrestricted -File ^"%root_path:"=%%~n0-%global_name%-generate-random-pass.ps1^" ^"%*^" -Verb runAs
') do set random_password_output=%%a
del "%root_path:"=%%~n0-%global_name%-generate-random-pass.ps1"
set tor_proxy_password="%random_password_output%"

for /f "tokens=*" %%a in ('
taskkill /F /IM tor.exe /T 2^>Nul
') do break

(
echo function Create-Tor-Password-Hash ^{
echo $torBrowser = "%userprofile%\Desktop\Tor Browser";
echo $TOR_Password = %tor_proxy_password%;
echo $TOR_HOST = "127.0.0.1";
echo $TOR_PORT = 9051;
echo $CTRL_PORT = 9151;
echo $tor_location = "$torBrowser\Browser\TorBrowser\Tor";
echo $torrc_defaults = "$torBrowser\Browser\TorBrowser\Data\Tor\torrc-defaults";
echo $torrc = "$torBrowser\Browser\TorBrowser\Data\Tor\torrc";
echo $tordata = "$torBrowser\Browser\TorBrowser\Data\Tor";
echo $geoIP = "$torBrowser\Browser\TorBrowser\Data\Tor\geoip";
echo $geoIPv6 = "$torBrowser\Browser\TorBrowser\Data\Tor\geoip6";
echo $oniondir = "$torBrowser\Browser\TorBrowser\Data\Tor\onion-auth";
echo $torExe = "$tor_location\tor.exe";
echo $controllerProcess = $PID;
echo function Get-OneToLastItem ^{ param ^($arr^) return $arr^[$arr.Length - 2^]^}
echo $TOR_HashPass_RAW = ^& "$torExe" --defaults-torrc $torrc -f $torrc DataDirectory $tordata ClientOnionAuthDir $oniondir GeoIPFile $geoIP GeoIPv6File $geoIPv6 --hash-password $TOR_Password ^| more;
echo $Tor_HashPass = Get-OneToLastItem^($TOR_HashPass_RAW^);
echo Write-Output $TOR^_HashPass^_RAW;
echo ^}
echo Create-Tor-Password-Hash
)>"%root_path:"=%%~n0-%global_name%-hash.ps1"
for /f "tokens=*" %%a in ('
powershell -ExecutionPolicy Unrestricted -File ^"%root_path:"=%%~n0-%global_name%-hash.ps1^" ^"%*^" -Verb runAs
') do set password_hash_output=%%a
del "%root_path:"=%%~n0-%global_name%-hash.ps1"
if %tor_proxy_password_enabled% == 1 echo %password_hash_output%
(
if %tor_proxy_bridge% == 1 echo Bridge obfs4 193.11.166.194:27025 1AE2C08904527FEA90C4C4F8C1083EA59FBC6FAF cert=ItvYZzW5tn6v3G4UnQa6Qz04Npro6e81AP70YujmK/KXwDFPTs3aHXcHp4n8Vt6w/bv8cA iat-mode=0
if %tor_proxy_bridge% == 1 echo Bridge obfs4 193.11.166.194:27015 2D82C2E354D531A68469ADF7F878FA6060C6BACA cert=4TLQPJrTSaDffMK7Nbao6LC7G9OW/NHkUwIdjLSS3KYf0Nv4/nQiiI8dY2TcsQx01NniOg iat-mode=0
if %tor_proxy_bridge% == 1 echo Bridge obfs4 193.11.166.194:27020 86AC7B8D430DAC4117E9F42C9EAED18133863AAF cert=0LDeJH4JzMDtkJJrFphJCiPqKx7loozKN7VNfuukMGfHO0Z8OGdzHVkhVAOfo1mUdv9cMg iat-mode=0
if %tor_proxy_bridge% == 1 echo Bridge obfs4 193.11.166.194:27025 1AE2C08904527FEA90C4C4F8C1083EA59FBC6FAF cert=ItvYZzW5tn6v3G4UnQa6Qz04Npro6e81AP70YujmK/KXwDFPTs3aHXcHp4n8Vt6w/bv8cA iat-mode=0
if %tor_proxy_bridge% == 1 echo Bridge obfs4 5.45.100.58:1337 66002E678B3A3C6968AB1944C233A82A34FCF0B8 cert=cZei7/b4KsHqb0tTn3mnAZ^+LruUAJ1^+yiXKwWxmNFLbpfQycmibCoYjlmX8n1gGskaiQLQ iat-mode=0
if %tor_proxy_bridge% == 1 echo Bridge obfs4 23.94.134.145:8082 1F36B62A1ECED5C884D188330D7291ED6A98827F cert=sCzTCeprtMZ3IyVjJo^+ksd0d/XYbPDT3TrfBM0nQv^+DL1LkFC5eRPmXPpAsfsUNeIxfzJA iat-mode=0
if %tor_proxy_bridge% == 1 echo Bridge obfs4 51.68.156.67:14638 66CDD5C6A077CAE91B497B22A9EAEAF7C55B023D cert=RqjodnFshvL9WvQx0jPN4OxxV0ITbmw1Y8Bsoz3aYXtl1ShWU4VfDTM64SXi9Ngq/MCBFw iat-mode=0
if %tor_proxy_bridge% == 1 echo Bridge obfs4 51.68.86.212:33427 75D8ECC96D0249ABE56E86D1F2325FBFAE02FB57 cert=3En/B81R63^+m1PiiQwhiAXsIMP9YmytOwTGBvckE4VlU8rFeqTkGoQkA8oayQ0f1MrxhMQ iat-mode=0
if %tor_proxy_bridge% == 1 echo Bridge obfs4 185.44.209.160:15045 3176C361647E23B1371E4EB444B05D6841386C11 cert=fgq1fgr8UDsBPUHY1Jbe9u6Ozj^+eF5/zsMk9yqfvpxNC02rtgM8/MKYR/V4P5FO4CDbrBw iat-mode=0
if %tor_proxy_bridge% == 1 echo Bridge obfs4 185.247.226.57:443 C2A28A62022616D17173FBB79EFF8162628EE136 cert=2LUpLXg7zAfYuCYFr3aMlYI2i1LMqj5we^+s06LtVrVrUV1EGcjoxTyj054Ykdyu1G5XTUQ iat-mode=0
if %tor_proxy_bridge% == 1 echo Bridge obfs4 139.162.53.29:9091 27243AB18BEDA83528E87D585DAFF625ABD04CE8 cert=IOcH6JY^+WUTsUh2zj43IRKqoQ8p/3QpZOCYitHLd9N8LbUOexnapA4NEAE/QFfdm3wDECw iat-mode=0
if %tor_proxy_bridge% == 2 echo Bridge snowflake 192.0.2.3:80 2B280B23E1107BB62ABFC40DDCC8824814F80A72 fingerprint=2B280B23E1107BB62ABFC40DDCC8824814F80A72 url=https://snowflake-broker.torproject.net.global.prod.fastly.net/ front=cdn.sstatic.net ice=stun:stun.l.google.com:19302,stun:stun.altar.com.pl:3478,stun:stun.antisip.com:3478,stun:stun.bluesip.net:3478,stun:stun.dus.net:3478,stun:stun.epygi.com:3478,stun:stun.sonetel.com:3478,stun:stun.sonetel.net:3478,stun:stun.stunprotocol.org:3478,stun:stun.uls.co.za:3478,stun:stun.voipgate.com:3478,stun:stun.voys.nl:3478 utls-imitate=hellorandomizedalpn
if %tor_proxy_bridge% == 3 echo Bridge meek_lite 192.0.2.18:80 BE776A53492E1E044A26F17306E1BC46A55A1625 url=https://meek.azureedge.net/ front=ajax.aspnetcdn.com
echo ClientOnionAuthDir %userprofile%\Desktop\Tor Browser\Browser\TorBrowser\Data\Tor\onion-auth
echo DataDirectory %userprofile%\Desktop\Tor Browser\Browser\TorBrowser\Data\Tor
echo GeoIPFile %userprofile%\Desktop\Tor Browser\Browser\TorBrowser\Data\Tor\geoip
echo GeoIPv6File %userprofile%\Desktop\Tor Browser\Browser\TorBrowser\Data\Tor\geoip6
echo UseBridges 1
echo AvoidDiskWrites 1
echo Log notice stdout
echo CookieAuthentication 0
if %tor_proxy_password_enabled% == 1 echo HashedControlPassword %password_hash_output%
echo DormantCanceledByStartup 1
echo ClientTransportPlugin meek_lite,obfs2,obfs3,obfs4,scramblesuit exec %userprofile%\Desktop\Tor Browser\Browser\TorBrowser\Tor\PluggableTransports\obfs4proxy.exe
echo ClientTransportPlugin snowflake exec %userprofile%\Desktop\Tor Browser\Browser\TorBrowser\Tor\PluggableTransports\snowflake-client.exe
)>"%userprofile%\Desktop\Tor Browser\Browser\TorBrowser\Data\Tor\torrc"
(
echo function Start-Tor {
echo $torBrowser = "%userprofile%\Desktop\Tor Browser";
echo $TOR_Password = %tor_proxy_password%;
echo $TOR_HOST = "127.0.0.1";
echo $TOR_PORT = 9051;
echo $CTRL_PORT = 9151;
echo $tor_location = "$torBrowser\Browser\TorBrowser\Tor";
echo $torrc_defaults = "$torBrowser\Browser\TorBrowser\Data\Tor\torrc-defaults";
echo $torrc = "$torBrowser\Browser\TorBrowser\Data\Tor\torrc";
echo $tordata = "$torBrowser\Browser\TorBrowser\Data\Tor";
echo $geoIP = "$torBrowser\Browser\TorBrowser\Data\Tor\geoip";
echo $geoIPv6 = "$torBrowser\Browser\TorBrowser\Data\Tor\geoip6";
echo $oniondir = "$torBrowser\Browser\TorBrowser\Data\Tor\onion-auth";
echo $torExe = "$tor_location\tor.exe";
echo $controllerProcess = $PID;
echo function Get-OneToLastItem { param ^($arr^) return $arr[$arr.Length - 2]}
echo $TOR_HashPass_RAW = ^& "$torExe" --defaults-torrc $torrc -f $torrc DataDirectory $tordata ClientOnionAuthDir $oniondir GeoIPFile $geoIP GeoIPv6File $geoIPv6 --hash-password $TOR_Password ^| more;
echo $Tor_HashPass = Get-OneToLastItem^($TOR_HashPass_RAW^);
echo $TOR_VERSION_RAW = ^& "$torExe" --defaults-torrc $torrc -f $torrc DataDirectory $tordata ClientOnionAuthDir $oniondir GeoIPFile $geoIP GeoIPv6File $geoIPv6 --version ^| more;
echo $Tor_Version = Get-OneToLastItem^($TOR_VERSION_RAW^);
echo Write-Host "Running $Tor_Version" -ForegroundColor DarkGray;
echo Write-Host "Press [Ctrl+C] to stop Tor service.";
if %tor_proxy_password_enabled% == 0 echo ^& "$torExe" --defaults-torrc $torrc -f $torrc DataDirectory $tordata ClientOnionAuthDir $oniondir GeoIPFile $geoIP GeoIPv6File $geoIPv6 ^+__ControlPort $CTRL_PORT ^+__SocksPort "${TOR_HOST}:$TOR_PORT ExtendedErrors IPv6Traffic PreferIPv6 KeepAliveIsolateSOCKSAuth" __OwningControllerProcess $controllerProcess ^| oh ^| more;
if %tor_proxy_password_enabled% == 1 echo ^& "$torExe" --defaults-torrc $torrc -f $torrc DataDirectory $tordata ClientOnionAuthDir $oniondir GeoIPFile $geoIP GeoIPv6File $geoIPv6 HashedControlPassword $TOR_HashPass_RAW ^+__ControlPort $CTRL_PORT ^+__SocksPort "${TOR_HOST}:$TOR_PORT ExtendedErrors IPv6Traffic PreferIPv6 KeepAliveIsolateSOCKSAuth" __OwningControllerProcess $controllerProcess ^| oh ^| more;
echo }
echo Start-Tor
)>"%root_path:"=%%~n0-%global_name%-tor-service.ps1"
start /MIN ^"^" powershell -ExecutionPolicy Unrestricted -File ^"%root_path:"=%%~n0-%global_name%-tor-service.ps1^" ^"%*^" -Verb runAs
if %custom_selenium_script% == 0 goto :start_tor
if not exist "%root_path:"=%%~n0-%global_name%.ps1" goto :start_tor
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
goto :skiptor
:start_tor
::start powershell code
(
if %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path:"=%';
echo Import-Module '%root_path:"=%WebDriver.dll';
echo Import-Module '%root_path:"=%WebDriver.Support.dll';
echo Import-Module '%root_path:"=%Selenium.WebDriverBackedSelenium.dll';
echo #Start-Process '%userprofile%\Desktop\Tor Browser\Browser\TorBrowser\Tor\tor.exe';
echo #Start-Process '%userprofile%\Desktop\Tor Browser\Browser\firefox.exe';
echo $%global_name%Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Options;
echo #https://www.selenium.dev/selenium/docs/api/dotnet/html/T_OpenQA_Selenium_Firefox_FirefoxDriverService.htm
echo $%global_name%Service = [OpenQA.Selenium.%global_drver_type%.%global_drver_type%DriverService]::CreateDefaultService^('%root_path:"=%','geckodriver.exe'^);
echo #$%global_name%Service.HideCommandPromptWindow = $true;
echo #$%global_name%Service.SuppressInitialDiagnosticInformation = $true;
echo $%global_name%Service.FirefoxBinaryPath = '%userprofile%\Desktop\Tor Browser\Browser\firefox.exe';
if %headlessbrowser% == 1 echo $%global_name%Options.addArgument^('--headless'^);
echo #$%global_name%Options.addArgument^("--kiosk"^);
echo #$%global_name%Options.addArgument^("--private-window"^);
echo $UserAgent = %custom_user_agent%;
echo #$%global_name%Options.addArgument^("--window-size=1920,1080"^);
echo #$%global_name%Options.addArgument^("--height=600"^);
echo #$%global_name%Options.addArgument^("--width=600"^);
echo #$%global_name%Options.addArgument^("--disable-blink-features=AutomationControlled"^);
echo $%global_name%Options.Profile = "%userprofile%\Desktop\Tor Browser\Browser\TorBrowser\Data\Browser\profile.default";
echo $%global_name%Options.setPreference^("general.useragent.override", "$UserAgent"^);
echo $%global_name%Options.setPreference^("webdriver.load.strategy", "unstable"^);
echo $%global_name%Options.setPreference^("network.proxy.type", 1^);
echo $%global_name%Options.setPreference^("network.proxy.socks","127.0.0.1"^);
echo $%global_name%Options.setPreference^("network.proxy.socks_port", 9051^);
echo $%global_name%Options.setPreference^("network.proxy.socks_remote_dns", $true^);
echo $%global_name%Options.setPreference^("network.proxy.socks_version", 5^);
if %tor_proxy_password_enabled% == 1 echo $%global_name%Options.setPreference^("network.proxy.socks_password", %tor_proxy_password%^)
echo $%global_name%Options.setPreference^("places.history.enabled", $false^);
echo $%global_name%Options.setPreference^("privacy.clearOnShutdown.offlineApps", $true^);
echo $%global_name%Options.setPreference^("privacy.clearOnShutdown.passwords", $true^);
echo $%global_name%Options.setPreference^("privacy.clearOnShutdown.siteSettings", $true^);
echo $%global_name%Options.setPreference^("privacy.sanitize.sanitizeOnShutdown", $true^);
echo $%global_name%Options.setPreference^("signon.rememberSignons", $false^);
echo $%global_name%Options.setPreference^("network.cookie.lifetimePolicy", 2^);
echo $%global_name%Options.setPreference^("network.dns.disablePrefetch", $true^);
echo $%global_name%Options.setPreference^("network.http.sendRefererHeader", 0^);
echo $%global_name%Options.setPreference^(^);
echo $%global_name%Options.PageLoadStrategy = 'Normal';
echo $%global_name%Options.LeaveBrowserRunning = $true;
echo $%global_name%Options.AcceptInsecureCertificates = $true;
echo $Options = New-Object OpenQA.Selenium.%global_drver_type%.%global_drver_type%Driver^($%global_name%Service,$%global_name%Options^);
echo #$Options.SwitchTo^(^).Window^($Options.WindowHandles[1]^);
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="connectButton"]'^)^);
echo $pageData.Click^(^);
echo Start-Sleep -s 5;
echo #$Options.Url^('%tor_selenium_browser_url%'^);
echo $Options.Navigate^(^).GoToURL^('%tor_selenium_browser_url%'^);
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="bbccookies-continue-button"]'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('/html/body/div[6]/header/div/div/nav[2]/ul/li[2]/a'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo Start-Sleep -s 2;
echo $pageTitle = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
echo #$Options.switchTo^(^).newWindow^(WindowType.TAB^);
echo #$Options.SwitchTo^(^).Window^($Options.WindowHandles[1]^);
echo $Options.Navigate^(^).GoToURL^('https://checkip.amazonaws.com/'^);
echo $pageData.Click^(^);
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('pre'^)^).getAttribute^('innerHTML'^);
echo Write-Output "Tor IP is : $pageData";
echo $%global_name%Service.Dispose^(^);
if %close_selenium% == 1 echo $Options.Close^(^);$Options.Quit^(^);
)>"%root_path:"=%%~n0-%global_name%.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
if %debug% == 0 if %custom_selenium_script% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
for /f "tokens=*" %%a in ('
taskkill /F /IM tor.exe /T 2^>Nul
') do break
del "%root_path:"=%%~n0-%global_name%-tor-service.ps1"
:skiptor

::PhantomJS Browser
if %phantomjs_selenium% == 0 goto :skipphantomjs
set global_name=phantomjs
set global_drver_type=PhantomJS
if %custom_selenium_script% == 0 goto :start_phantomjs
if not exist "%root_path:"=%%~n0-%global_name%.ps1" goto :start_phantomjs
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
goto :skipphantomjs
:start_phantomjs
::start powershell code
(
if %debug% == 1 echo Set-PSDebug -Trace 1;
echo $SeleniumDriverPath = '%root_path:"=%';
echo Import-Module '%root_path:"=%WebDriver3.11.0.dll';
echo Import-Module '%root_path:"=%WebDriver.Support3.11.0.dll';
echo Import-Module '%root_path:"=%Selenium.WebDriverBackedSelenium3.11.0.dll';
echo [OpenQA.Selenium.PhantomJS.PhantomJSOptions]$options = New-Object OpenQA.Selenium.PhantomJS.PhantomJSOptions;
echo $service = [OpenQA.Selenium.PhantomJS.PhantomJSDriverService]::CreateDefaultService^('%root_path:"=%','phantomjs.exe'^);
echo $service.HideCommandPromptWindow = $true;
echo $service.SuppressInitialDiagnosticInformation = $true;
echo $service.IgnoreSslErrors = $true;
echo $service.WebSecurity = $false;
if %headlessbrowser% == 1 echo $options.addArgument^('--headless'^);
echo #$caps = [OpenQA.Selenium.Remote.DesiredCapabilities]::phantomjs^(^);
echo #$caps.SetCapability^('CapabilityType.ACCEPT_SSL_CERTS', $true^);
echo $cli_args = @^(^);
echo $cli_args ^+=  "--web-security=no";
echo $cli_args ^+= "--ignore-ssl-errors=yes";
echo $options.AddAdditionalCapability^("phantomjs.cli.args", $cli_args^);
echo $options.AddAdditionalCapability^("phantomjs.page.settings.ignore-ssl-errors", $true^);
echo $options.AddAdditionalCapability^("phantomjs.page.settings.webSecurityEnabled", $false^);
echo $options.AddAdditionalCapability^("phantomjs.page.settings.userAgent", %custom_user_agent%^);
echo $phantomjspath = '%root_path:"=%';
echo $driver = New-Object OpenQA.Selenium.PhantomJS.PhantomJSDriver^($service, $options^);
echo $driver.Navigate^(^).GoToURL^('%phantomjs_selenium_browser_url%'^);
echo $pageTitle = $driver.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
echo $timeout = 10;
echo [OpenQA.Selenium.Support.UI.WebDriverWait]$wait = new-object OpenQA.Selenium.Support.UI.WebDriverWait ^($driver,[System.TimeSpan]::FromSeconds^($timeout^)^);
echo [OpenQA.Selenium.Interactions.Actions]$actions = new-object OpenQA.Selenium.Interactions.Actions ^($driver^);
echo $selector = 'li.ssrcss-t1nvxi-GlobalNavigationProduct:nth-child^(2^) ^> a:nth-child^(1^)';
echo $wait.Until^([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementExists^([OpenQA.Selenium.By]::CssSelector^($selector^)^)^);
echo $element = $driver.FindElement^([OpenQA.Selenium.By]::CssSelector^($selector^)^);
echo Write-Host $element.getAttribute^('href'^);
echo $driver.Navigate^(^).GoToURL^($element.getAttribute^('href'^)^); #this will navigate browser to the element
echo $wait.Until^([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementExists^([OpenQA.Selenium.By]::tagname^('title'^)^)^);
echo $pageTitle = $driver.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
echo $driver.Navigate^(^).GoToURL^('https://ifconfig.me/ua'^);
echo $wait.Until^([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementExists^([OpenQA.Selenium.By]::tagname^('pre'^)^)^);
echo $pageTitle = $driver.FindElement^([OpenQA.Selenium.By]::tagname^('pre'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
echo $driver.Dispose^(^);
if %close_selenium% == 1 echo $driver.Close^(^);$driver.Quit^(^);
)>"%root_path:"=%%~n0-%global_name%.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-%global_name%.ps1" "%*" -Verb runAs
if %debug% == 0 if %custom_selenium_script% == 0 del "%root_path:"=%%~n0-%global_name%.ps1"
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
if [%file_name_to_extract%]==[*] echo set FilesInZip = app.NameSpace^(ZipFile^).items
if [%file_name_to_extract%]==[*] echo app.NameSpace^(ExtractTo^).CopyHere FilesInZip, 4
if [%delete_download%]==[1] echo fso.DeleteFile ZipFile
echo Set fso = Nothing
echo Set objShell = Nothing
)>"%root_path:"=%%~n0.vbs"
cscript //nologo "%root_path:"=%%~n0.vbs"
if %debug% == 0 del "%root_path:"=%%~n0.vbs"
:next_download
goto :skip_version_grab
:start_version_grab
(
echo var http = WScript.CreateObject^('MSXML2.ServerXMLHTTP.6.0'^);
echo var url = WScript.Arguments.Item^(0^)
echo http.open^("GET", url, false^);
echo http.send^(^);
echo if ^(http.status === 200^) WScript.Echo^(http.responseText^);
echo WScript.Quit^(0^);
)>"%root_path:"=%%~n0-ip.vbs"
for /f "tokens=*" %%a in ('
cscript //nologo ^"%root_path:"=%%~n0-ip.vbs^"^ %site%
') do set "vbs_output=%%a"
del "%root_path:"=%%~n0-ip.vbs"
set site=https://chromedriver.storage.googleapis.com/%vbs_output%/chromedriver_win32.zip
:skip_version_grab
goto :skip_latest_driver_github
:get_latest_driver_github
::Get latest geckodriver
(
echo $repo = "%grab_latest_repo:"=%"
echo $filenamePattern = "*%grab_latest_file:"=%"
echo $preRelease = $%grab_latest_prerelease%
echo if ^($preRelease^) {
echo $releasesUri = "https://api.github.com/repos/$repo/releases"
echo $downloadUri = ^(^(Invoke-RestMethod -Method GET -Uri $releasesUri^)[0].assets ^| Where-Object name -like $filenamePattern ^).browser_download_url
echo } else {
echo $releasesUri = "https://api.github.com/repos/$repo/releases/latest"
echo $downloadUri = ^(^(Invoke-RestMethod -Method GET -Uri $releasesUri^).assets ^| Where-Object name -like $filenamePattern ^).browser_download_url
echo }
echo Write-Output $downloadUri ^| Out-File "%root_path:"=%%~n0-psoutput.txt"
)>"%root_path:"=%%~n0-latest-driver.ps1"
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-latest-driver.ps1" "%*" -Verb runAs
for /f "tokens=*" %%a in ('type "%root_path:"=%%~n0-psoutput.txt"') do set "latest_driver_output=%%a"
del "%root_path:"=%%~n0-latest-driver.ps1"
del "%root_path:"=%%~n0-psoutput.txt"
:skip_latest_driver_github
goto :skip_latest_download_link
:get_latest_download_link
::Get latest download link of a webpage
(
echo $url = "%grab_latest_url:"=%"
echo $html_tag = "%grab_latest_html_tag:"=%"
echo $matching_string = "%grab_latest_matching_string:"=%"
echo foreach^($i in %grab_low_range%..%grab_high_range%^){
echo $downloadUri = ^(^(Invoke-WebRequest $url -UseBasicParsing -MaximumRedirection 10^).Links ^| Where-Object $html_tag -like $matching_string^)[$i].href
echo if ^( -not ^([string]::IsNullOrEmpty^($downloadUri^)^) ^) {
echo $true_variable=%redirect_true_or_false%;
echo if ^($true_variable^) {
echo if ^($downloadUri -match "^^/"^) {
echo $var = [System.Uri]$url
echo $scheme = $var.Scheme
echo $domain = $var.Host
echo $downloadUri = $scheme ^+ "://" ^+ $domain ^+ $downloadUri
echo }
echo $downloadURL = $downloadUri
echo $request = Invoke-WebRequest -UseBasicParsing -Method Head -Uri $downloadURL
echo $redirectedUri = $request.BaseResponse.ResponseUri.AbsoluteUri
echo $downloadUri = $redirectedUri
echo }
echo Write-Output $downloadUri ^| Out-File "%root_path:"=%%~n0-psoutput.txt"
echo break;
echo }
echo }
)>"%root_path:"=%%~n0-latest-download.ps1"
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-latest-download.ps1" "%*" -Verb runAs
for /f "tokens=*" %%a in ('type "%root_path:"=%%~n0-psoutput.txt"') do set "latest_download_output=%%a"
del "%root_path:"=%%~n0-latest-download.ps1"
del "%root_path:"=%%~n0-psoutput.txt"
del "%root_path:"=%%~n0-psfilenameoutput.txt"
:skip_latest_download_link
goto :skip_selenium_driver_patching
:start_selenium_driver_patching
:: https://gist.github.com/C0nw0nk/f3fe5541567bf93998d22dca64eeb185
(
echo $regexA = 'cdc_.{22}';
echo $ThisFile = '%root_path:"=%%driver_file_to_patch%';
echo $new_date="10/10/2000 13:37:02";
echo if ^( ^(Get-ChildItem $ThisFile^).CreationTime -notlike $new_date ^) {
echo Write-Output "%driver_file_to_patch% Patching now";
echo } else {
echo Write-Output "%driver_file_to_patch% is already patched";
echo Exit;
echo }
echo function Get-RandomCharacters^($length, $characters^) { 
echo $random = 1..$length ^| ForEach-Object { Get-Random -Maximum $characters.length }
echo $private:ofs="";
echo return [String]$characters[$random];
echo }
echo $random ^+= Get-RandomCharacters -length 3 -characters 'abcdefghijklmnopqrstuvwxyz';
echo $random = 'cdc_' ^+ $random;
echo $randomupper = Get-RandomCharacters -length 1 -characters 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
echo $randomtwo = Get-RandomCharacters -length 12 -characters 'abcdefghijklmnopqrstuvwxyz';
echo $randomuppertwo = Get-RandomCharacters -length 2 -characters 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
echo $randomthree = Get-RandomCharacters -length 4 -characters 'abcdefghijklmnopqrstuvwxyz';
echo $output = $random ^+= $randomupper ^+= $randomtwo ^+= $randomuppertwo ^+= $randomthree;
echo Write-Output "New cdc string is : $output";
echo Get-ChildItem $ThisFile ^| ForEach-Object {
echo $c = ^(Get-Content $_.FullName -Raw^);
echo if ^($c -match $regexA^) {
echo $existing_cdc = $matches[0];
echo Write-Output "Existing cdc to be replaced: $existing_cdc";
echo }
echo }
echo $byteEncParam = 
echo  if ^($IsCoreCLR^) { @{ AsByteStream = $true } } 
echo  else            { @{ Encoding = 'Byte' } }
echo $data = Get-Content @byteEncParam -ReadCount 0  $ThisFile
echo $dataAsHexString = [BitConverter]::ToString^($data^)
echo $search = $existing_cdc
echo $replacement = $output
echo $searchAsHexString = [BitConverter]::ToString^([Text.Encoding]::UTF8.GetBytes^($search^)^)
echo $replaceAsHexString = [BitConverter]::ToString^([Text.Encoding]::UTF8.GetBytes^($replacement^)^)
echo $dataAsHexString = $dataAsHexString.Replace^($searchAsHexString, $replaceAsHexString^)
echo $modifiedData = [byte[]] ^($dataAsHexString -split '-' -replace '^^', '0x'^)
echo Set-Content @byteEncParam $ThisFile -Value $modifiedData
echo ^(Get-ChildItem $ThisFile^).CreationTime = $new_date;
echo ^(Get-ChildItem $ThisFile^).LastWriteTime = $new_date;
)>"%root_path:"=%%~n0-driver-patch.ps1"
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0-driver-patch.ps1" "%*" -Verb runAs
del "%root_path:"=%%~n0-driver-patch.ps1"
:skip_selenium_driver_patching

winget install Microsoft.DotNet.Runtime.7 >nul
winget install Microsoft.DotNet.Runtime.6 >nul
winget install Microsoft.DotNet.Runtime.5 >nul
winget install Microsoft.DotNet.Runtime.3_1 >nul
winget install Microsoft.DotNet.DesktopRuntime.7 >nul
winget install Microsoft.DotNet.DesktopRuntime.6 >nul
winget install Microsoft.DotNet.DesktopRuntime.5 >nul
winget install Microsoft.DotNet.DesktopRuntime.3_1 >nul

::https://www.selenium.dev/documentation/webdriver/browsers/

::download the internet explorer portable instance
if %internetexplorer_selenium% == 1 (
if not exist "%root_path:"=%IEDriverServer.exe" (
	if not defined IEDriverServer_exe (
		if not defined get_latest_iedriverserver_64 (
			set grab_latest_repo="SeleniumHQ/selenium"
			set grab_latest_file="_x64_*.zip"
			set grab_latest_prerelease=false
			set get_latest_iedriverserver_64=true
			goto :get_latest_driver_github
		)
		set downloadurl=%latest_driver_output%
		if %PROCESSOR_ARCHITECTURE%==x86 (
			if not defined get_latest_iedriverserver_32 (
				set grab_latest_repo="SeleniumHQ/selenium"
				set grab_latest_file="_Win32_*.zip"
				set grab_latest_prerelease=false
				set get_latest_iedriverserver_32=true
				goto :get_latest_driver_github
			)
			set downloadurl=%latest_driver_output%
		)
		set file_name_to_extract=IEDriverServer.exe
		set delete_download=1
		set IEDriverServer_exe=true
		goto :start_download
	)
)
)

::download the microsoft edge
if %microsoftedge_selenium% == 1 (
if not exist "%root_path:"=%msedgedriver.exe" (
	::microsoft edge driver
	if not defined msedgedriver_exe (
		if not defined get_latest_msedgedriver_exe (
			set grab_latest_url="https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/"
			set grab_latest_html_tag="aria-label"
			set grab_latest_matching_string="*Stable channel version * group win64 link"
			::grab href occurance between 15 and 20 these are in the stable column if microsoft have missed a windows version the next id in que will be tested
			set grab_low_range=15
			set grab_high_range=20
			set redirect_true_or_false=$false
			set get_latest_msedgedriver_exe=true
			goto :get_latest_download_link
		)
		set downloadurl=%latest_download_output%
		if %PROCESSOR_ARCHITECTURE%==x86 (
			set downloadurl=%latest_download_output:_win64=_win32%
		)
		set file_name_to_extract=msedgedriver.exe
		set delete_download=1
		set msedgedriver_exe=true
		goto :start_download
	)
)
)

if %vivaldi_selenium% == 0 goto :skipversion_vivaldi
if not defined vivaldi_version_check (
set vivaldi_version_check=true
) else (
goto :skipversion_vivaldi
)
::get vivaldi chromedriver version to extract the right file that will be compatible
set alias=REG QUERY ^"HKEY_CURRENT_USER\SOFTWARE\Vivaldi\BLBeacon^"
for /f "tokens=*" %%a in ('%alias% /s ^| FIND ^"version^" 2^>Nul') do (
set vivaldi_version=%%a
::set "vivaldi_version=!vivaldi_version:~1,-1!"
set "vivaldi_version=!vivaldi_version:.=!"
set "vivaldi_version=!vivaldi_version: =!"
set "vivaldi_version=!vivaldi_version:Version=!"
set "vivaldi_version=!vivaldi_version:Target=!"
set "vivaldi_version=!vivaldi_version:REG_SZ=!"
set "vivaldi_version=!vivaldi_version:~,+3!"
set site=https://chromedriver.storage.googleapis.com/LATEST_RELEASE_!vivaldi_version!
)
::if [!vivaldi_version!]==[] set site=https://chromedriver.storage.googleapis.com/LATEST_RELEASE
goto :start_version_grab
::end vivaldi check
:skipversion_vivaldi

::vivaldi runs a older chromedriver build vivaldi://about/page/ will show you the version you will need
if %vivaldi_selenium% == 1 (
if not exist "%root_path:"=%vivaldichromedriver.exe" (
	if not defined vivaldi_chromedriver_exe (
		set downloadurl=%site%
		set file_name_to_extract=chromedriver.exe
		set delete_download=1
		set vivaldi_chromedriver_exe=true
		goto :start_download
	)
	rename "%root_path:"=%chromedriver.exe" "vivaldichromedriver.exe"
)
)

::opera runs a different version but their github is delayed so... opera://about
if %opera_selenium% == 1 (
if not exist "%root_path:"=%operadriver.exe" (
	::download the opera webdriver portable instance
	if not defined operadriver_exe (
		set downloadurl=https://chromedriver.storage.googleapis.com/108.0.5359.22/chromedriver_win32.zip
		set file_name_to_extract=chromedriver.exe
		set delete_download=1
		set operadriver_exe=true
		goto :start_download
	)
	rename "%root_path:"=%chromedriver.exe" "operadriver.exe"
)
)

set chromedriver_needed=0
if %chrome_selenium% == 1 set chromedriver_needed=1
if %opera_selenium% == 1 set chromedriver_needed=1
if %vivaldi_selenium% == 1 set chromedriver_needed=1
if %brave_selenium% == 1 set chromedriver_needed=1
if %chromedriver_needed% == 1 (
if not exist "%root_path:"=%chromedriver.exe" (
	if not defined chromedriver_version (
		set chromedriver_version=true
		set site=https://chromedriver.storage.googleapis.com/LATEST_RELEASE
		goto :start_version_grab
	)
	::download the google chrome portable instance
	if not defined chromedriver_exe (
		::only 32bit windows available chromedriver ?
		set downloadurl=https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_win32.zip
		set file_name_to_extract=chromedriver.exe
		set delete_download=1
		set chromedriver_exe=true
		goto :start_download
	)
)
)

set firefoxdriver_needed=0
if %firefox_selenium% == 1 set firefoxdriver_needed=1
if %tor_selenium% == 1 set firefoxdriver_needed=1
if %firefoxdriver_needed% == 1 (
if not exist "%root_path:"=%geckodriver.exe" (
	::download the mozilla firefox webdriver portable instance
	if not defined geckodriver_exe (
		::Get latest geckodriver
		if not defined get_latest_geckodriver_64 (
			set grab_latest_repo="mozilla/geckodriver"
			set grab_latest_file="win64.zip"
			set grab_latest_prerelease=false
			set get_latest_geckodriver_64=true
			goto :get_latest_driver_github
		)
		::End get latest geckodriver
		set downloadurl=%latest_driver_output%
		if %PROCESSOR_ARCHITECTURE%==x86 (
			if not defined get_latest_geckodriver_32 (
				set grab_latest_repo="mozilla/geckodriver"
				set grab_latest_file="win32.zip"
				set grab_latest_prerelease=false
				set get_latest_geckodriver_32=true
				goto :get_latest_driver_github
			)
			set downloadurl=%latest_driver_output%
		)
		set file_name_to_extract=geckodriver.exe
		set delete_download=1
		set geckodriver_exe=true
		goto :start_download
	)
)
)

::get netframework installed version to extract the right .dll file that will be compatible
set alias=REG QUERY ^"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP^"
for /f "tokens=*" %%a in ('%alias% /s ^| FIND ^"Version^" 2^>Nul') do (
set framework_version=%%a
::set "framework_version=!framework_version:~1,-1!"
set "framework_version=!framework_version:.=!"
set "framework_version=!framework_version: =!"
set "framework_version=!framework_version:Version=!"
set "framework_version=!framework_version:Target=!"
set "framework_version=!framework_version:REG_SZ=!"
if !framework_version! gtr 2000000 set net_framework=netstandard2.0
if !framework_version! gtr 3500000 set net_framework=net35
if !framework_version! gtr 4000000 set net_framework=net40
if !framework_version! gtr 4500000 set net_framework=net45
)
::end netframework check

:: nulled out grabbing latest version of phantomjs the beta version what is latest is awful lol stick with stable
:: if not defined get_latest_phantomjs (
::	set grab_latest_url="https://bitbucket.org/ariya/phantomjs/downloads/"
::	set grab_latest_html_tag="href"
::	set grab_latest_matching_string="*windows.zip"
::	set grab_low_range=0
::	set grab_high_range=0
::	set get_latest_phantomjs=true
::	goto :get_latest_download_link
:: )
:: set downloadurl=https://bitbucket.org%latest_download_output%

if %phantomjs_selenium% == 1 (
if not exist "%root_path:"=%phantomjs.exe" (
	::download the phantomjs webdriver portable instance
	if not defined phantomjs_exe (
		set downloadurl=https://www.nuget.org/api/v2/package/PhantomJS/2.1.1
		set delete_download=0
		set phantomjs_exe=true
		goto :start_download
	)
	if not defined phantomjs_zip (
		rename "%downloadpath:"=%" "%filename:"=%.zip"
		set downloadurl="%root_path:"=%%filename:"=%.zip"
		set file_name_to_extract=phantomjs.exe
		set delete_download=1
		set phantomjs_zip=true
		goto :start_download
	)
)
if not exist "%root_path:"=%WebDriver3.11.0.dll" (
	::phantomjs is not compatible with selenium versions above >3.11 so we add backwards compatibility
	::download selenium
	if not defined webdriver_dll_phantomjs (
		set downloadurl=https://globalcdn.nuget.org/packages/selenium.webdriver.3.11.0.nupkg
		set delete_download=0
		set webdriver_dll_phantomjs=true
		goto :start_download
	)
	::selenium by default is a nupkg its a renamed zip file lets make it a zip again so we can extract the dynamic library file we need.
	if not defined webdriver_zip_phantomjs (
		rename "%downloadpath:"=%" "%filename:"=%.zip"
		set downloadurl="%root_path:"=%selenium.webdriver.3.11.0.zip"
		set file_name_to_extract=lib\%net_framework%\WebDriver.dll
		set delete_download=1
		set webdriver_zip_phantomjs=true
		goto :start_download
	)
	rename "%root_path:"=%WebDriver.dll" "WebDriver3.11.0.dll"
)
if not exist "%root_path:"=%WebDriver.Support3.11.0.dll" (
	::download selenium support driver dll
	if not defined webdriver_support_dll_phantomjs (
		set downloadurl=https://globalcdn.nuget.org/packages/selenium.support.3.11.0.nupkg
		set delete_download=0
		set webdriver_support_dll_phantomjs=true
		goto :start_download
	)
	::selenium by default is a nupkg its a renamed zip file lets make it a zip again so we can extract the dynamic library file we need.
	if not defined webdriver_support_zip_phantomjs (
		rename "%downloadpath:"=%" "%filename:"=%.zip"
		set downloadurl="%root_path:"=%selenium.support.3.11.0.zip"
		set file_name_to_extract=lib\%net_framework%\WebDriver.Support.dll
		set delete_download=1
		set webdriver_support_zip_phantomjs=true
		goto :start_download
	)
	rename "%root_path:"=%WebDriver.Support.dll" "WebDriver.Support3.11.0.dll"
)
if not exist "%root_path:"=%Selenium.WebDriverBackedSelenium3.11.0.dll" (
	::download selenium backdated support driver dll
	if not defined webdriver_backed_support_dll_phantomjs (
		set downloadurl=https://globalcdn.nuget.org/packages/selenium.webdriverbackedselenium.3.11.0.nupkg
		set delete_download=0
		set webdriver_backed_support_dll_phantomjs=true
		goto :start_download
	)
	::selenium by default is a nupkg its a renamed zip file lets make it a zip again so we can extract the dynamic library file we need.
	if not defined webdriver_backed_zip_phantomjs (
		rename "%downloadpath:"=%" "%filename:"=%.zip"
		set downloadurl="%root_path:"=%selenium.webdriverbackedselenium.3.11.0.zip"
		set file_name_to_extract=lib\%net_framework%\Selenium.WebDriverBackedSelenium.dll
		set delete_download=1
		set webdriver_backed_zip_phantomjs=true
		goto :start_download
	)
	rename "%root_path:"=%Selenium.WebDriverBackedSelenium.dll" "Selenium.WebDriverBackedSelenium3.11.0.dll"
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
if not exist "%root_path:"=%WebDriver.dll" (
	if not defined webdriver_dll (
		if not defined get_latest_webdriver_dll (
			set grab_latest_url="https://www.nuget.org/packages/Selenium.WebDriver"
			set grab_latest_html_tag="data-track"
			set grab_latest_matching_string="*outbound-manual-download"
			set grab_low_range=0
			set grab_high_range=0
			set redirect_true_or_false=$false
			set get_latest_webdriver_dll=true
			goto :get_latest_download_link
		)
		set downloadurl=%latest_download_output%
		set delete_download=0
		set webdriver_dll=true
		goto :start_download
	)
	::selenium by default is a nupkg its a renamed zip file lets make it a zip again so we can extract the dynamic library file we need.
	if not defined webdriver_zip (
		rename "%downloadpath:"=%" "%filename:"=%.zip"
		set downloadurl="%root_path:"=%%filename:"=%.zip"
		set file_name_to_extract=lib\%net_framework%\WebDriver.dll
		set delete_download=1
		set webdriver_zip=true
		goto :start_download
	)
)
if not exist "%root_path:"=%WebDriver.Support.dll" (
	::download selenium support driver dll
	if not defined webdriver_support_dll (
		if not defined get_latest_webdriver_support_dll (
			set grab_latest_url="https://www.nuget.org/packages/Selenium.Support"
			set grab_latest_html_tag="data-track"
			set grab_latest_matching_string="*outbound-manual-download"
			set grab_low_range=0
			set grab_high_range=0
			set redirect_true_or_false=$false
			set get_latest_webdriver_support_dll=true
			goto :get_latest_download_link
		)
		set downloadurl=%latest_download_output%
		set delete_download=0
		set webdriver_support_dll=true
		goto :start_download
	)
	::selenium by default is a nupkg its a renamed zip file lets make it a zip again so we can extract the dynamic library file we need.
	if not defined webdriver_support_zip (
		rename "%downloadpath:"=%" "%filename:"=%.zip"
		set downloadurl="%root_path:"=%%filename:"=%.zip"
		set file_name_to_extract=lib\%net_framework%\WebDriver.Support.dll
		set delete_download=1
		set webdriver_support_zip=true
		goto :start_download
	)
)
if not exist "%root_path:"=%Selenium.WebDriverBackedSelenium.dll" (
	::download selenium backdated support driver dll
	if not defined webdriver_backed_support_dll (
		if not defined get_latest_webdriver_backedselenium_dll (
			set grab_latest_url="https://www.nuget.org/packages/Selenium.WebDriverBackedSelenium"
			set grab_latest_html_tag="data-track"
			set grab_latest_matching_string="*outbound-manual-download"
			set grab_low_range=0
			set grab_high_range=0
			set redirect_true_or_false=$false
			set get_latest_webdriver_backedselenium_dll=true
			goto :get_latest_download_link
		)
		set downloadurl=%latest_download_output%
		set delete_download=0
		set webdriver_backed_support_dll=true
		goto :start_download
	)
	::selenium by default is a nupkg its a renamed zip file lets make it a zip again so we can extract the dynamic library file we need.
	if not defined webdriver_backed_zip (
		rename "%downloadpath:"=%" "%filename:"=%.zip"
		set downloadurl="%root_path:"=%%filename:"=%.zip"
		set file_name_to_extract=lib\%net_framework%\Selenium.WebDriverBackedSelenium.dll
		set delete_download=1
		set webdriver_backed_zip=true
		goto :start_download
	)
)

::firefox browser downloads
if %firefox_selenium% == 1 (
	if not exist "%programs_path%\Mozilla Firefox\firefox.exe" (
		if not defined firefoxinstaller_exe (
			if not defined get_latest_firefox_msi (
				set grab_latest_url="https://www.mozilla.org/en-GB/firefox/all/#product-desktop-release"
				set grab_latest_html_tag="data-download-version"
				set grab_latest_matching_string="*win64-msi"
				set grab_low_range=0
				set grab_high_range=0
				set redirect_true_or_false=$true
				set get_latest_firefox_msi=true
				goto :get_latest_download_link
			)
			set downloadurl=%latest_download_output%
			if %PROCESSOR_ARCHITECTURE%==x86 (
				set downloadurl=%latest_download_output:win64=win32%
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
	if not exist "%LocalAppData%\BraveSoftware\Brave-Browser\Application\brave.exe" (
		if not defined braveinstaller_exe (
			set downloadurl=https://github.com/brave/brave-browser/releases/download/v1.46.141/BraveBrowserStandaloneSilentSetup.exe
			if %PROCESSOR_ARCHITECTURE%==x86 (
				set downloadurl=https://github.com/brave/brave-browser/releases/download/v1.46.141/BraveBrowserStandaloneSilentSetup32.exe
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
			if not defined get_latest_vivaldi_exe (
				set grab_latest_url="https://vivaldi.com/download/"
				set grab_latest_html_tag="class"
				set grab_latest_matching_string="*download-button download-link*"
				set grab_low_range=0
				set grab_high_range=0
				set redirect_true_or_false=$false
				set get_latest_vivaldi_exe=true
				goto :get_latest_download_link
			)
			set downloadurl=%latest_download_output%
			if %PROCESSOR_ARCHITECTURE%==x86 (
				set downloadurl=%latest_download_output:.x64=%
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
			if not defined get_latest_tor_exe (
				set grab_latest_url="https://www.torproject.org/download/"
				set grab_latest_html_tag="class"
				set grab_latest_matching_string="btn btn-primary mt-4 downloadLink"
				set grab_low_range=0
				set grab_high_range=0
				set redirect_true_or_false=$false
				set get_latest_tor_exe=true
				goto :get_latest_download_link
			)
			set downloadurl=https://www.torproject.org%latest_download_output%
			if %PROCESSOR_ARCHITECTURE%==x86 (
				set downloadurl=%downloadurl:-win64=%
			)
			set file_name_to_extract=TorInstaller.exe
			set delete_download=0
			set torinstaller_exe=true
			goto :start_download
		) else (
			call "%root_path:"=%%filename:"=%%fileextension:"=%" /S
		)
	)
	if not exist "%userprofile%\Desktop\Tor Browser\Browser\TorBrowser\Data\Tor\onion-auth" (
		mkdir "%userprofile%\Desktop\Tor Browser\Browser\TorBrowser\Data\Tor\onion-auth"
	)
)

::Driver patching replacing detectable cdc strings that cloudflare and such services will make a javascript variable call for a known string
if %selenium_driver_patches% == 1 (
	if exist "%root_path:"=%chromedriver.exe" (
		if not defined chromedriver_patching (
			set driver_file_to_patch=chromedriver.exe
			set chromedriver_patching=true
			goto :start_selenium_driver_patching
		)
	)
	if exist "%root_path:"=%msedgedriver.exe" (
		if not defined msedgedriver_patching (
			set driver_file_to_patch=msedgedriver.exe
			set msedgedriver_patching=true
			goto :start_selenium_driver_patching
		)
	)
	if exist "%root_path:"=%operadriver.exe" (
		if not defined operadriver_patching (
			set driver_file_to_patch=operadriver.exe
			set operadriver_patching=true
			goto :start_selenium_driver_patching
		)
	)
	if exist "%root_path:"=%vivaldichromedriver.exe" (
		if not defined vivaldichromedriver_patching (
			set driver_file_to_patch=vivaldichromedriver.exe
			set vivaldichromedriver_patching=true
			goto :start_selenium_driver_patching
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
	if exist "%root_path:"=%vivaldichromedriver.exe" (
		for /f "tokens=*" %%a in ('
			taskkill /F /IM vivaldichromedriver.exe /T 2^>Nul
		') do break
		del "%root_path:"=%vivaldichromedriver.exe"
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
	::PhantomJS Cleanup
	if %phantomjs_selenium% == 1 (
		if exist "%root_path:"=%WebDriver3.11.0.dll" (
			del "%root_path:"=%WebDriver3.11.0.dll"
		)
		if exist "%root_path:"=%WebDriver.Support3.11.0.dll" (
			del "%root_path:"=%WebDriver.Support3.11.0.dll"
		)
		if exist "%root_path:"=%Selenium.WebDriverBackedSelenium3.11.0.dll" (
			del "%root_path:"=%Selenium.WebDriverBackedSelenium3.11.0.dll"
		)
	)
	::End Selenium cleanup
:skipcleanup

if %pause_window% == 1 pause

timeout /t %schedule% >nul

exit
