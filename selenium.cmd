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

:: End Edit DO NOT TOUCH ANYTHING BELOW THIS POINT UNLESS YOU KNOW WHAT YOUR DOING!

if defined varpass goto :start_exe

set root_path=%~dp0

::Elevate to admin rights

:start
net session >nul 2>&1
if %errorlevel% == 0 (
goto :admin
) else (
@pushd %~dp0 & fltmc | find ^".^" && (powershell start '%~f0' ' %*' -verb runas 2>nul && exit /b)
)
goto :start
:admin

:start_loop
if "%~1"=="" (
start /wait /B %~dp0%~nx0 go 2^>Nul
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
if /I %internetexplorer_selenium% == 0 goto :skipie
::start powershell code
(
if /I %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path%';
echo Import-Module '%root_path%WebDriver.dll';
echo $ieOptions = New-Object OpenQA.Selenium.IE.InternetExplorerOptions;
echo $ieOptions.IntroduceInstabilityByIgnoringProtectedModeSettings = $true;
echo $ieOptions.IgnoreZoomLevel = $true;
echo $ieOptions.EnsureCleanSession = $true;
echo $ieOptions.PageLoadStrategy = 'Normal';
echo $ieOptions.EdgeExecutablePath = 'C:\Program Files ^(x86^)\Microsoft\Edge\Application\msedge.exe';
echo $ieOptions.useCreateProcessApiToLaunchIe^(^);
echo $ieOptions.addCommandSwitches^("--ie-mode-test"^);
echo $Options = New-Object OpenQA.Selenium.IE.InternetExplorerDriver^($workingpath,$ieOptions^);
echo $Options.Url^('%internetexplorer_selenium_browser_url%'^);
echo $Options.Navigate^(^).GoToURL^('%internetexplorer_selenium_browser_url%'^);
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="header-content"]/nav/div[1]/div/div[2]/ul[2]/li[2]/a'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo Start-Sleep -s 2;
echo $pageTitle = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
if /I %close_selenium% == 1 echo $Options.Close^(^);$Options.Quit^(^);
)>"%root_path%%~n0-ie-temp.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File %root_path%%~n0-ie-temp.ps1 %*
if /I %debug% == 0 del %root_path%%~n0-ie-temp.ps1
:skipie

::Microsoft Edge
if /I %microsoftedge_selenium% == 0 goto :skipedge
::https://www.selenium.dev/selenium/docs/api/dotnet/html/N_OpenQA_Selenium_Edge.htm
::start powershell code
(
if /I %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path%';
echo Import-Module '%root_path%WebDriver.dll';
echo $edgeOptions = New-Object OpenQA.Selenium.Edge.EdgeOptions;
if /I %headlessbrowser% == 1 echo $edgeOptions.AddArgument^('--headless'^);$edgeOptions.AddArgument^(^);
echo $edgeOptions.PageLoadStrategy = 'Normal';
echo $edgeOptions.AcceptInsecureCertificates = $True;
echo $Options = New-Object OpenQA.Selenium.Edge.EdgeDriver^($workingpath,$edgeOptions^);
echo $Options.Navigate^(^).GoToURL^('%microsoftedge_selenium_browser_url%'^);
echo Start-Sleep -s 2;
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="header-content"]/nav/div[1]/div/div[2]/ul[2]/li[2]/a'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo Start-Sleep -s 2;
echo $pageTitle = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
if /I %close_selenium% == 1 echo $Options.Close^(^);$Options.Quit^(^);
)>"%root_path%%~n0-edge-temp.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File %root_path%%~n0-edge-temp.ps1 %*
if /I %debug% == 0 del %root_path%%~n0-edge-temp.ps1
:skipedge

::Chrome
if /I %chrome_selenium% == 0 goto :skipchrome
::start powershell code
(
if /I %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path%';
echo Import-Module '%root_path%WebDriver.dll';
echo $chromeOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions;
if /I %headlessbrowser% == 1 echo $chromeOptions.AddArgument^('--headless'^);$chromeOptions.AddArgument^(^);
echo $chromeOptions.addArgument^("start-maximized"^);
echo $chromeOptions.addArgument^("homepage='https://www.google.co.uk/'"^);
echo $chromeOptions.addExcludedArgument^("enable-logging"^);
echo $chromeOptions.addExcludedArgument^("enable-automation"^);
echo $chromeOptions.LeaveBrowserRunning = $True;
echo $chromeOptions.AcceptInsecureCertificates = $true;
echo $Options = New-Object OpenQA.Selenium.Chrome.ChromeDriver^($workingpath,$chromeOptions^);
echo $Options.Navigate^(^).GoToURL^('%chrome_selenium_browser_url%'^);
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="header-content"]/nav/div[1]/div/div[2]/ul[2]/li[2]/a'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo Start-Sleep -s 2;
echo $pageTitle = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
)>"%root_path%%~n0-chrome-temp.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File %root_path%%~n0-chrome-temp.ps1 %*
if /I %debug% == 0 del %root_path%%~n0-chrome-temp.ps1
:skipchrome

::Firefox
if /I %firefox_selenium% == 0 goto :skipfirefox
::start powershell code
(
if /I %debug% == 1 echo Set-PSDebug -Trace 1;
echo $workingpath = '%root_path%';
echo Import-Module '%root_path%WebDriver.dll';
echo $firefoxoptions = New-Object OpenQA.Selenium.Firefox.FirefoxOptions;
if /I %headlessbrowser% == 1 echo $firefoxoptions.AddArgument^('--headless'^);$firefoxoptions.AddArgument^(^);
echo $Options = New-Object OpenQA.Selenium.Firefox.FirefoxDriver^($workingpath,$firefoxoptions^);
echo $Options.Url^('%firefox_selenium_browser_url%'^);
echo $Options.Navigate^(^).GoToURL^('%firefox_selenium_browser_url%'^);
echo $pageData = $Options.FindElement^([OpenQA.Selenium.By]::xpath^('//^*[@id="header-content"]/nav/div[1]/div/div[2]/ul[2]/li[2]/a'^)^);
echo $pageData.Click^(^);
echo $pageData.Url^(^); #this will navigate browser to the clicked element
echo Start-Sleep -s 2;
echo $pageTitle = $Options.FindElement^([OpenQA.Selenium.By]::tagname^('title'^)^).getAttribute^('innerHTML'^);
echo Write-Output $pageTitle;
if /I %close_selenium% == 1 echo $Options.Close^(^);$Options.Quit^(^);
)>"%root_path%%~n0-firefox-temp.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File %root_path%%~n0-firefox-temp.ps1 %*
if /I %debug% == 0 del %root_path%%~n0-firefox-temp.ps1
:skipfirefox

goto :end_script

goto :next_download
:start_download
FOR /f %%i IN ("%downloadurl%") DO set filename=%%~ni& set fileextension=%%~xi
set downloadpath=%root_path%%filename%%fileextension%
(
echo Dim oXMLHTTP
echo Dim oStream
echo Set fso = CreateObject^("Scripting.FileSystemObject"^)
echo If Not fso.FileExists^("%downloadpath%"^) Then
echo Set oXMLHTTP = CreateObject^("MSXML2.ServerXMLHTTP.6.0"^)
echo oXMLHTTP.Open "GET", "%downloadurl%", False
echo oXMLHTTP.SetRequestHeader "User-Agent", "Mozilla/5.0 ^(Windows NT 10.0; Win64; rv:51.0^) Gecko/20100101 Firefox/51.0"
echo oXMLHTTP.SetRequestHeader "Referer", "https://www.google.co.uk/"
echo oXMLHTTP.SetRequestHeader "DNT", "1"
echo oXMLHTTP.Send
echo If oXMLHTTP.Status = 200 Then
echo Set oStream = CreateObject^("ADODB.Stream"^)
echo oStream.Open
echo oStream.Type = 1
echo oStream.Write oXMLHTTP.responseBody
echo oStream.SaveToFile "%downloadpath%"
echo oStream.Close
echo End If
echo End If
echo ZipFile="%downloadpath%"
echo ExtractTo="%root_path%"
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
if /I %delete_download% == 1 echo fso.DeleteFile ZipFile
echo Set fso = Nothing
echo Set objShell = Nothing
)>"%root_path%%~n0-temp.vbs"
cscript //nologo %root_path%%~n0-temp.vbs
if /I %debug% == 0 del %root_path%%~n0-temp.vbs
:next_download

::https://www.selenium.dev/documentation/webdriver/browsers/

::download the internet explorer portable instance
if %internetexplorer_selenium% == 1 (
	if not defined IEDriverServer_exe (
		set downloadurl=https://github.com/SeleniumHQ/selenium/releases/download/selenium-4.6.0/IEDriverServer_Win32_4.6.0.zip
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

if %chrome_selenium% == 1 (
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

if %firefox_selenium% == 1 (
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

::download selenium
if not defined webdriver_dll (
	set downloadurl=https://globalcdn.nuget.org/packages/selenium.webdriver.4.6.0.nupkg
	set delete_download=0
	set webdriver_dll=true
	goto :start_download
)
::selenium by default is a nupkg its a renamed zip file lets make it a zip again so we can extract the dynamic library file we need.
if not defined webdriver_zip (
	rename "%downloadpath%" "%filename%.zip"
	set downloadurl=%root_path%%selenium.webdriver.4.6.0.zip
	set file_name_to_extract=lib\net48\WebDriver.dll
	set delete_download=1
	set webdriver_zip=true
	goto :start_download
)

::firefox browser downloads
if %firefox_selenium% == 1 (
	if not exist "%programs_path%\Mozilla Firefox\firefox.exe" (
		echo mozilla firefux not installed
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
			call %windir%\%system_folder%\msiexec.exe /fa "%root_path%%filename%%fileextension%" /qn
			call %windir%\%system_folder%\msiexec.exe /i "%root_path%%filename%%fileextension%" /qn
		)
	)
)

::chrome browser downloads
if %chrome_selenium% == 1 (
	if not exist "%programs_path%\Google\Chrome\Application\chrome.exe" (
		echo google chrome not installed
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
			call %windir%\%system_folder%\msiexec.exe /fa "%root_path%%filename%%fileextension%" /qn
			call %windir%\%system_folder%\msiexec.exe /i "%root_path%%filename%%fileextension%" /qn
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
			set downloadurl=http://go.microsoft.com/fwlink/?LinkID=2093437
			if %PROCESSOR_ARCHITECTURE%==x86 (
				set downloadurl=http://go.microsoft.com/fwlink/?LinkID=2093505
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
			call %windir%\%system_folder%\msiexec.exe /fa "%root_path%%filename%%fileextension%" /qn
			call %windir%\%system_folder%\msiexec.exe /i "%root_path%%filename%%fileextension%" /qn
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
::	call %downloadpath% /s
::	del %downloadpath%
::) else (
::	call ^"%programs_path%\WinRAR\unrar.exe^" x ^"%downloadpath%^" ^"lib\net48\webdriver.dll^" ^"%root_path%^"
::)

goto :start_exe
:end_script

if /I %cleanup% == 1 (
	if exist "%root_path%IEDriverServer.exe" (
		for /f "tokens=*" %%a in ('
			taskkill /im IEDriverServer.exe /t /f 2^>Nul
		') do break
		del %root_path%IEDriverServer.exe
	)
	if exist "%root_path%msedgedriver.exe" (
		for /f "tokens=*" %%a in ('
			taskkill /im msedgedriver.exe /t /f 2^>Nul
		') do break
		del %root_path%msedgedriver.exe
	)
	if exist "%root_path%chromedriver.exe" (
		for /f "tokens=*" %%a in ('
			taskkill /im chromedriver.exe /t /f 2^>Nul
		') do break
		del %root_path%chromedriver.exe
	)
	if exist "%root_path%geckodriver.exe" (
		for /f "tokens=*" %%a in ('
			taskkill /im geckodriver.exe /t /f 2^>Nul
		') do break
		del %root_path%geckodriver.exe
	)

	if exist "%root_path%firefox.msi" (
		del %root_path%firefox.msi
	)
	if exist "%root_path%microsoftedge.msi" (
		del %root_path%microsoftedge.msi
	)
	if exist "%root_path%googlechromestandaloneenterprise.msi" (
		del %root_path%googlechromestandaloneenterprise.msi
	)
	if exist "%root_path%WebDriver.dll" (
		del %root_path%WebDriver.dll
	)
)

if /I %pause_window% == 1 pause

timeout /t %schedule% >nul

exit
