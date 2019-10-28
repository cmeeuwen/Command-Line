@echo off

Echo BDE recovery key protectors tool
Echo Written by Chris Meeuwen
Echo ____________________________________________________ 
Echo:

md c:\Bitlocker

NET USE r: \\shared.bridgewellres.com\files\backups\Encryption\Bitlocker\BDERecovery /User:%Username% %Password%

manage-bde -protectors c: -get > "C:\bitlocker\BDETEMP.txt"
wmic csproduct get identifyingnumber /value >> "C:\bitlocker\BDETEMP.txt"

for /F "skip=2 tokens=2 delims=," %%A in ('wmic csproduct get identifyingnumber /value /FORMAT:csv') do (set "serial=%%A")

ren c:\bitlocker\BDETEMP.txt %serial%.txt

copy "C:\bitlocker\*.txt" r:\
del /f "c:\bitlocker\*.txt"

rd c:\Bitlocker

Echo ____________________________________________________
Echo:
Echo Service Tag %serial% BDE recovery Keys being pulled!
Echo Recovery Keys pulled to bderecovery network share 
Echo under the following name %serial%.txt
pause