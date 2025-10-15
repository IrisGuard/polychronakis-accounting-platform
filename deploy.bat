@echo off
REM 🚀 Deployment Script για GitHub Pages
REM Νίκος Πολυχρονάκης & Συνεργάτες - Λογιστική Πλατφόρμα

echo 🏢 Λογιστική Πλατφόρμα - Deployment Script
echo ==========================================
echo.

REM Έλεγχος αν υπάρχει git repository
if not exist ".git" (
    echo ❌ Δεν βρέθηκε git repository. Αρχικοποιώντας...
    git init
    echo ✅ Git repository αρχικοποιήθηκε
)

REM Προσθήκη όλων των αρχείων
echo 📁 Προσθήκη αρχείων στο git...
git add .

REM Commit message
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "COMMIT_MSG=🚀 Deploy: %YYYY%-%MM%-%DD% %HH%:%Min%:%Sec%"

echo 💾 Commit: %COMMIT_MSG%
git commit -m "%COMMIT_MSG%"

REM Έλεγχος αν υπάρχει remote origin
git remote | findstr "origin" >nul
if errorlevel 1 (
    echo ⚠️  Δεν βρέθηκε remote origin.
    echo 📝 Παρακαλώ προσθέστε το GitHub repository:
    echo    git remote add origin https://github.com/YOUR_USERNAME/polychronakis-accounting-platform.git
    echo.
    echo 🔗 Ή αντικαταστήστε το YOUR_USERNAME με το GitHub username σας
    pause
    exit /b 1
)

REM Push στο GitHub
echo 🚀 Αποστολή στο GitHub...
git push origin main

if %errorlevel% equ 0 (
    echo.
    echo ✅ Deployment ολοκληρώθηκε επιτυχώς!
    echo.
    echo 🌐 Το σάιτ θα είναι διαθέσιμο σε 5-10 λεπτά
    echo.
    echo 📱 Δοκιμάστε:
    echo    - Mobile compatibility
    echo    - Contact form
    echo    - Admin panel
    echo.
    echo 🔧 Για custom domain, δείτε το DEPLOYMENT-GUIDE.md
) else (
    echo.
    echo ❌ Σφάλμα κατά το deployment
    echo 🔍 Ελέγξτε τα GitHub credentials και τη σύνδεση
)

pause
