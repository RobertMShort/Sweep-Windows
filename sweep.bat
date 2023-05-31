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

	set /p "ip=Enter IP: "

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

endlocal	
goto :eof
