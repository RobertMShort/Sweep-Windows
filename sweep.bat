@echo OFF
setlocal enabledelayedexpansion
goto :main

:main
setlocal

	chcp 65001 > nul
	echo.
	type logo.txt
	echo.
	echo.

	set /p "ip=Enter Network IP: "

	break>ping.txt

	for /L %%g in (1, 1, 5) do (
		ping -n 1 -w 1 %ip%.%%g | find "TTL=" >> ping.txt
	)

	echo.
	echo ----------Active Hosts----------
	break>ips.txt
	for /f "tokens=3" %%a in (ping.txt) do (
		set b=%%a
		echo !b::=%! >> ips.txt
	)

	type ips.txt

	break>ports.txt

	nmap -iL ips.txt >> ports.txt

	echo.
	echo ----------Active Ports----------

	type ports.txt

	set /p "scan=Run scan on individual target?: y/n to quit: "

	if "!scan!"=="n" (
		exit /B
	)
 
	if "!scan!"=="y" (
		set /p "scanip=Enter IP: "
		set /p "scantype=Enter 's' for Service Scan, 'a' for Aggressive Scan: "
	)

	if "!scantype!"=="s" (
		nmap -sV -v !scanip! > servicescan.txt
		type servicescan.txt
	) 

	if "!scantype!"=="a" (
		nmap -A -v !scanip! > aggressivescan.txt
		type aggressivescan.txt
	)


endlocal	
goto :eof
