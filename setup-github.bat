@echo off
REM 🚀 GitHub Setup Script για Λογιστική Πλατφόρμα
REM Νίκος Πολυχρονάκης & Συνεργάτες

echo.
echo 🏢 Λογιστική Πλατφόρμα - GitHub Setup
echo =====================================
echo.

REM Έλεγχος αν υπάρχει git
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Git δεν είναι εγκατεστημένο
    echo 📥 Κατεβάστε από: https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)

echo ✅ Git βρέθηκε
echo.

REM Ερώτηση για GitHub username
set /p GITHUB_USERNAME="🔗 Εισάγετε το GitHub username σας: "
if "%GITHUB_USERNAME%"=="" (
    echo ❌ Πρέπει να εισάγετε GitHub username
    pause
    exit /b 1
)

echo.
echo 📝 Δημιουργία repository...
echo.

REM Αρχικοποίηση git repository
if not exist ".git" (
    echo 🔧 Αρχικοποίηση git repository...
    git init
    echo ✅ Git repository αρχικοποιήθηκε
)

REM Προσθήκη remote origin
echo 🔗 Προσθήκη GitHub remote...
git remote remove origin 2>nul
git remote add origin https://github.com/%GITHUB_USERNAME%/polychronakis-accounting-platform.git
echo ✅ Remote origin προστέθηκε

REM Προσθήκη αρχείων
echo 📁 Προσθήκη αρχείων...
git add .

REM Commit
echo 💾 Δημιουργία commit...
git commit -m "🚀 Initial commit - Accounting platform setup"

echo.
echo 🌐 Repository URL: https://github.com/%GITHUB_USERNAME%/polychronakis-accounting-platform
echo.

REM Ερώτηση για push
set /p PUSH_NOW="🚀 Θέλετε να στείλετε τα αρχεία στο GitHub τώρα; (y/n): "
if /i "%PUSH_NOW%"=="y" (
    echo.
    echo 📤 Αποστολή στο GitHub...
    git push -u origin main
    
    if %errorlevel% equ 0 (
        echo.
        echo ✅ Τα αρχεία στάλθηκαν επιτυχώς!
        echo.
        echo 🌐 Το σάιτ θα είναι διαθέσιμο σε 5-10 λεπτά στο:
        echo    https://%GITHUB_USERNAME%.github.io/polychronakis-accounting-platform
        echo.
        echo 📱 Επόμενα βήματα:
        echo    1. Πηγαίνετε στο repository
        echo    2. Settings → Pages
        echo    3. Source: Deploy from a branch
        echo    4. Branch: main
        echo    5. Save
        echo.
        echo 🔧 Για custom domain, δείτε το DEPLOYMENT-GUIDE.md
    ) else (
        echo.
        echo ❌ Σφάλμα κατά το push
        echo 🔍 Ελέγξτε τα GitHub credentials
        echo 💡 Μπορείτε να δοκιμάσετε ξανά με: git push -u origin main
    )
) else (
    echo.
    echo ℹ️  Τα αρχεία είναι έτοιμα για push
    echo 💡 Για να τα στείλετε αργότερα, τρέξτε: git push -u origin main
)

echo.
echo 📚 Οδηγοί:
echo    - QUICK-START.md: Γρήγορη εκκίνηση
echo    - DEPLOYMENT-GUIDE.md: Πλήρης οδηγός deployment
echo    - USER-GUIDE.md: Οδηγός χρήστη
echo    - EMAIL-INTEGRATION.md: Email setup
echo.

pause
