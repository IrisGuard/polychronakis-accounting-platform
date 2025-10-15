#!/bin/bash

# 🚀 Deployment Script για GitHub Pages
# Νίκος Πολυχρονάκης & Συνεργάτες - Λογιστική Πλατφόρμα

echo "🏢 Λογιστική Πλατφόρμα - Deployment Script"
echo "=========================================="
echo ""

# Έλεγχος αν υπάρχει git repository
if [ ! -d ".git" ]; then
    echo "❌ Δεν βρέθηκε git repository. Αρχικοποιώντας..."
    git init
    echo "✅ Git repository αρχικοποιήθηκε"
fi

# Προσθήκη όλων των αρχείων
echo "📁 Προσθήκη αρχείων στο git..."
git add .

# Commit message
COMMIT_MSG="🚀 Deploy: $(date '+%Y-%m-%d %H:%M:%S')"
echo "💾 Commit: $COMMIT_MSG"
git commit -m "$COMMIT_MSG"

# Έλεγχος αν υπάρχει remote origin
if ! git remote | grep -q "origin"; then
    echo "⚠️  Δεν βρέθηκε remote origin."
    echo "📝 Παρακαλώ προσθέστε το GitHub repository:"
    echo "   git remote add origin https://github.com/YOUR_USERNAME/polychronakis-accounting-platform.git"
    echo ""
    echo "🔗 Ή αντικαταστήστε το YOUR_USERNAME με το GitHub username σας"
    exit 1
fi

# Push στο GitHub
echo "🚀 Αποστολή στο GitHub..."
git push origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Deployment ολοκληρώθηκε επιτυχώς!"
    echo ""
    echo "🌐 Το σάιτ θα είναι διαθέσιμο σε 5-10 λεπτά στο:"
    echo "   https://$(git config --get remote.origin.url | sed 's/.*github.com[:/]\([^/]*\)\/.*/\1/').github.io/polychronakis-accounting-platform"
    echo ""
    echo "📱 Δοκιμάστε:"
    echo "   - Mobile compatibility"
    echo "   - Contact form"
    echo "   - Admin panel"
    echo ""
    echo "🔧 Για custom domain, δείτε το DEPLOYMENT-GUIDE.md"
else
    echo ""
    echo "❌ Σφάλμα κατά το deployment"
    echo "🔍 Ελέγξτε τα GitHub credentials και τη σύνδεση"
fi
