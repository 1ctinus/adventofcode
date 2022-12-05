@echo off
setlocal ENABLEDELAYEDEXPANSION
set a1=JHGMZNTF
set a2=VWJ
set a3=GVLJBTH
set a4=BPJNCDVL
set a5=FWSMPRG
set a6=GHCFBNVM
set a7=DHGMR
set a8=HNMVZD
set a9=GNFH
set b1=ZN
set b2=MCD
set b3=P
	echo !b1! !b2! !b3!
for /f "tokens=1-6 delims= " %%a in (5.txt) do (
    set servers=a%%d
	set rline=
	set rem=%%b
	set dest=a%%f
	call set line=%%!servers!:~-!rem!%%
	call set !servers!=%%!servers!:~0,-!rem!%%
	set num=0
	call :LOOP
	call set !dest!=%%!dest!%%!rline!
)
:LOOP
	call set tmpa=%%line:~%num%,1%%%
	set /a num+=1
	if not "!tmpa!" equ "" (
	set rline=!tmpa!!rline!
	goto LOOP
)
echo %a1% %a2% %a3% %a4% %a5% %a6% %a7% %a8% %a9%