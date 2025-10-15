# Οδηγός Ενσωμάτωσης Email για Φόρμα Επικοινωνίας

## Περιγραφή Λύσης

Η σελίδα επικοινωνίας που δημιουργήθηκε διαθέτει:

### ✅ **Εύκολη Διαχείριση Στοιχείων**
- **Διαχειριστικό Panel**: Κουμπί "Διαχείριση" στο header
- **Αποθήκευση στον Browser**: Τα στοιχεία αποθηκεύονται τοπικά
- **Άμεση Ενημέρωση**: Οι αλλαγές εφαρμόζονται αυτόματα
- **Μόνιμη Αποθήκευση**: Τα στοιχεία διατηρούνται μεταξύ των επισκέψεων

### 📝 **Στοιχεία που Μπορούν να Αλλάξουν**
1. **Σταθερό Τηλέφωνο**
2. **Κινητό Τηλέφωνο** 
3. **Email**
4. **Διεύθυνση** (πλήρης διεύθυνση γραφείου)
5. **Ώρες Λειτουργίας**
6. **Περιγραφή Υπηρεσιών**

## Email Integration Options

### Option 1: EmailJS (Recommended - Εύκολη Εγκατάσταση)

**Πλεονεκτήματα:**
- Δωρεάν μέχρι 200 emails/μήνα
- Δεν χρειάζεται backend server
- Εύκολη εγκατάσταση
- Υποστηρίζει Gmail, Outlook, Yahoo

**Βήματα Εγκατάστασης:**

1. **Δημιουργία Λογαριασμού EmailJS**
   - Πηγαίνετε στο [EmailJS.com](https://www.emailjs.com)
   - Δημιουργήστε δωρεάν λογαριασμό
   - Επιβεβαιώστε το email σας

2. **Σύνδεση Email Service**
   ```javascript
   // Παράδειγμα για Gmail
   Service ID: gmail
   Service Name: Gmail
   ```

3. **Δημιουργία Email Template**
   ```html
   Νέο Μήνυμα από τη Σελίδα Επικοινωνίας
   
   Όνομα: {{from_name}}
   Email: {{from_email}}
   Τηλέφωνο: {{phone}}
   Θέμα: {{subject}}
   
   Μήνυμα:
   {{message}}
   
   ---
   Στάλθηκε από: polychronakis-accounting.gr
   ```

4. **Ενημέρωση Κώδικα**
   ```javascript
   // Αντικατάσταση των τιμών στον κώδικα
   const EMAILJS_CONFIG = {
       serviceId: 'YOUR_SERVICE_ID',     // από EmailJS dashboard
       templateId: 'YOUR_TEMPLATE_ID',   // από EmailJS dashboard
       publicKey: 'YOUR_PUBLIC_KEY'      // από EmailJS dashboard
   };
   ```

### Option 2: Netlify Forms (Για Netlify Hosting)

**Εάν χρησιμοποιείτε Netlify για hosting:**

```html
<!-- Προσθήκη στη φόρμα -->
<form name="contact" method="POST" data-netlify="true" onSubmit={handleSubmit}>
    <input type="hidden" name="form-name" value="contact" />
    <!-- Υπόλοιπα fields -->
</form>
```

### Option 3: PHP Contact Form (Για Traditional Hosting)

**Δημιουργία contact.php:**

```php
<?php
if ($_POST) {
    $name = $_POST['name'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];
    $subject = $_POST['subject'];
    $message = $_POST['message'];
    
    $to = "info@polychronakis-accounting.gr";
    $email_subject = "Νέο μήνυμα: " . $subject;
    
    $email_body = "Νέο μήνυμα από τη σελίδα επικοινωνίας:\n\n";
    $email_body .= "Όνομα: " . $name . "\n";
    $email_body .= "Email: " . $email . "\n";
    $email_body .= "Τηλέφωνο: " . $phone . "\n\n";
    $email_body .= "Μήνυμα:\n" . $message;
    
    $headers = "From: " . $email . "\r\n";
    $headers .= "Reply-To: " . $email . "\r\n";
    
    if (mail($to, $email_subject, $email_body, $headers)) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false]);
    }
}
?>
```

### Option 4: Formspree (Third-party Service)

```html
<!-- Αλλαγή action στη φόρμα -->
<form action="https://formspree.io/f/YOUR_FORM_ID" method="POST">
    <!-- fields -->
</form>
```

## Λεπτομερείς Οδηγίες EmailJS

### Βήμα 1: Account Setup

1. Πηγαίνετε στο [EmailJS.com](https://www.emailjs.com)
2. Κάντε Sign Up με το email σας
3. Επιβεβαιώστε το email

### Βήμα 2: Email Service Configuration

1. Πηγαίνετε στο "Email Services"
2. Κάντε κλικ "Add New Service"
3. Επιλέξτε το email provider σας (Gmail/Outlook)
4. Συνδέστε το λογαριασμό σας
5. Σημειώστε το **Service ID**

### Βήμα 3: Email Template

1. Πηγαίνετε στο "Email Templates"
2. Κάντε κλικ "Create New Template"
3. Χρησιμοποιήστε αυτό το template:

```
Subject: Νέο Μήνυμα - {{subject}}

Αγαπητέ κ. Πολυχρονάκη,

Λάβατε νέο μήνυμα από τη σελίδα επικοινωνίας:

Στοιχεία Αποστολέα:
- Όνομα: {{from_name}}
- Email: {{from_email}}
- Τηλέφωνο: {{phone}}

Θέμα: {{subject}}

Μήνυμα:
{{message}}

---
Αυτό το email στάλθηκε αυτόματα από τη σελίδα επικοινωνίας.
Για απάντηση, χρησιμοποιήστε το email: {{from_email}}
```

4. Σημειώστε το **Template ID**

### Βήμα 4: Integration Code

Αντικαταστήστε τον κώδικα στο contact-page.html:

```javascript
// Αντικαταστήστε αυτές τις τιμές
const EMAILJS_CONFIG = {
    serviceId: 'service_1234567',    // Το δικό σας Service ID
    templateId: 'template_1234567',  // Το δικό σας Template ID
    publicKey: 'user_1234567890'     // Το δικό σας Public Key
};

// Ενεργοποιήστε το EmailJS (uncomment)
useEffect(() => {
    emailjs.init(EMAILJS_CONFIG.publicKey);
}, []);

// Στη handleSubmit function, ενεργοποιήστε τον πραγματικό κώδικα:
await emailjs.send(
    EMAILJS_CONFIG.serviceId,
    EMAILJS_CONFIG.templateId,
    {
        from_name: formData.name,
        from_email: formData.email,
        phone: formData.phone,
        subject: formData.subject,
        message: formData.message,
        to_email: contactInfo.email
    },
    EMAILJS_CONFIG.publicKey
);
```

## Security & Backup Considerations

### 🔒 **Security**
- Τα στοιχεία αποθηκεύονται στον browser (localStorage)
- Δεν αποστέλλονται ευαίσθητα δεδομένα
- EmailJS δεν αποκαλύπτει το email σας

### 💾 **Backup Στοιχείων**

**Εξαγωγή Στοιχείων:**
```javascript
// Στο browser console
const data = localStorage.getItem('polychronakis_contact_info');
console.log(data); // Copy αυτό το string
```

**Εισαγωγή Στοιχείων:**
```javascript
// Στο browser console
const data = 'YOUR_BACKUP_STRING';
localStorage.setItem('polychronakis_contact_info', data);
location.reload();
```

### 📱 **Mobile Compatibility**
- Responsive design για όλες τις συσκευές
- Touch-friendly διαχειριστικό panel
- Βελτιστοποιημένη εμπειρία χρήστη

## Deployment με GitHub Pages

### Αρχεία για Upload:
1. **contact.html** → μετονομάστε σε **contact.html**
2. Προσθέστε link στην κύρια πλατφόρμα:

```html
<!-- Στο navigation menu -->
<div className="nav-item" onClick={() => window.location.href = './contact.html'}>
    <span>📞</span>
    <span>Επικοινωνία</span>
</div>
```

### URL Structure:
```
https://[username].github.io/polychronakis-accounting-platform/contact.html
```

## Advanced Features (Future)

### 📊 **Analytics Integration**
```javascript
// Google Analytics tracking
gtag('event', 'contact_form_submit', {
    'event_category': 'engagement',
    'event_label': formData.subject
});
```

### 🤖 **Auto-Response**
```javascript
// EmailJS με δεύτερο template για auto-response
await emailjs.send(
    serviceId,
    'auto_response_template',
    { to_email: formData.email, name: formData.name }
);
```

### 📧 **Email Notifications**
- Ειδοποίηση στο κινητό όταν έρχεται νέο μήνυμα
- Αυτόματη απάντηση στον πελάτη
- Weekly summary των μηνυμάτων

## Troubleshooting

### Συχνά Προβλήματα:

**1. Τα emails δεν φτάνουν:**
- Ελέγξτε το spam folder
- Επιβεβαιώστε τα EmailJS credentials
- Ελέγξτε το email template

**2. Τα στοιχεία δεν αποθηκεύονται:**
- Ελέγξτε αν είναι ενεργοποιημένα τα cookies
- Δοκιμάστε σε άλλο browser
- Clear browser cache

**3. Το admin panel δεν ανοίγει:**
- Ελέγξτε console για errors
- Δοκιμάστε σε desktop browser
- Refresh τη σελίδα

---

**Σημείωση:** Η σελίδα επικοινωνίας είναι πλήρως λειτουργική και μπορεί να χρησιμοποιηθεί αμέσως. Για πραγματική αποστολή emails, ακολουθήστε έναν από τους παραπάνω οδηγούς integration.