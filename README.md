# Saving Quests 💰

แอพพลิเคชันจัดการการเงินส่วนตัวที่ช่วยให้คุณติดตามรายรับ-รายจ่าย วิเคราะห์พฤติกรรมการใช้จ่าย และวางแผนการออมเงินได้อย่างมีประสิทธิภาพ

## 🚀 คุณสมบัติหลัก

### 📊 การจัดการธุรกรรม
- **บันทึกรายรับ-รายจ่าย** พร้อมหมวดหมู่และรายละเอียด
- **ตัวกรองข้อมูล** สามารถกรองตามประเภท หมวดหมู่ และช่วงเวลา
- **จัดกลุ่มตามวัน** แสดงธุรกรรมแยกตามวันที่ เรียงจากใหม่ไปเก่า
- **สรุปยอดคงเหลือ** คำนวณจากรายการธุรกรรมทั้งหมด

### 🏦 ระบบ Wallet
- **Wallet เริ่มต้น** สร้างกระเป๋าเงินหลักโดยอัตโนมัติ
- **ติดตามยอดคงเหลือ** แบบ Real-time

### 📱 ส่วนติดต่อผู้ใช้
- **การออกแบบที่ใช้งานง่าย** พร้อม Bottom Navigation
- **ฟอร์มเพิ่ม/แก้ไขธุรกรรม** ที่สมบูรณ์
- **การแสดงผลแบบ Card** สำหรับข้อมูลต่างๆ

## 🏗️ สถาปัตกรรมแอพพลิเคชัน

### Architecture Pattern
แอพพลิเคชันใช้ **MVC Pattern** ร่วมกับ **GetX** เป็น State Management

```
├── Models (ข้อมูล)
├── Views (หน้าจอ)
├── Controllers (ตัวควบคุม)
└── Components (ส่วนประกอบ UI)
```

### โครงสร้างโฟลเดอร์

#### 📁 Models
```
models/
├── enum/
│   ├── transaction_category/     # หมวดหมู่ธุรกรรม (อาหาร, ช็อปปิ้ง, บิล ฯลฯ)
│   └── transaction_type/         # ประเภทธุรกรรม (รายรับ/รายจ่าย)
├── transaction/                  # โมเดลธุรกรรม
└── wallet/                       # โมเดล Wallet
```

#### 🎮 Controllers
```
controllers/
├── wallet_controller.dart        # จัดการ Wallet และธุรกรรม
├── transaction_form_controller.dart  # ควบคุมฟอร์มธุรกรรม
├── view_controller.dart          # ควบคุมการนำทาง
└── bindings/
    └── initial_bindings.dart     # ผูก Controllers เข้ากับแอพ
```

#### 📱 Views
```
views/
├── main_view.dart               # หน้าหลัก
├── transaction_view.dart        # หน้ารายการธุรกรรม
└── wallet_view.dart            # หน้า Wallet
```

#### 🧩 Components
```
components/
├── app/
│   ├── transaction/             # ส่วนประกอบธุรกรรม
│   │   ├── statements.dart      # สรุปรายการ
│   │   ├── transaction_card.dart # การ์ดธุรกรรม
│   │   ├── transaction_filter_sheet.dart # ตัวกรอง
│   │   ├── transaction_form.dart # ฟอร์มเพิ่ม/แก้ไข
│   │   └── transaction_item.dart # รายการธุรกรรม
│   └── wallet/
│       └── balance_card.dart    # การ์ดแสดงยอดคงเหลือ
├── share/
│   └── app_card.dart           # การ์ดพื้นฐาน
└── ui/
    └── app_bottom_navigation.dart # Navigation Bar
```

## 🛠️ เทคโนโลยีและเครื่องมือ

### Core Technologies
- **Flutter** - Framework สำหรับพัฒนาแอพมือถือ
- **Dart** - ภาษาโปรแกรมมิ่ง

### State Management & Navigation
- **GetX** - State Management, Dependency Injection และ Route Management
- **Get** - Reactive Programming และ Navigation

### การจัดเก็บข้อมูล
- **Hive** - NoSQL Database แบบ Local
  - `wallets` Box - จัดเก็บข้อมูル Wallet
  - `transactions` Box - จัดเก็บธุรกรรม
  - `transaction_types` Box - ประเภทธุรกรรม
  - `transaction_categories` Box - หมวดหมู่ธุรกรรม

### Code Generation
- **build_runner** - สร้างโค้ดอัตโนมัติสำหรับ Hive Models

## 📊 Data Models

### Transaction (ธุรกรรม)
```dart
class Transaction {
  String name;          // ชื่อธุรกรรม
  String desc;          // รายละเอียด
  double amount;        // จำนวนเงิน
  TransactionType type; // ประเภท (รายรับ/รายจ่าย)
  TransactionCategory category; // หมวดหมู่
  DateTime createdAt;   // วันที่สร้าง
  DateTime updatedAt;   // วันที่แก้ไข
  dynamic walletId;     // ID ของ Wallet
}
```

### TransactionType (ประเภทธุรกรรม)
- รายรับ (Income)
- รายจ่าย (Expense)

### TransactionCategory (หมวดหมู่)
- อื่นๆ (Other)
- อาหาร (Food)
- ช็อปปิ้ง (Shopping)
- ค่าใช้จ่ายประจำ (Bills)
- การเดินทาง (Transport)
- ความบันเทิง (Entertainment)

## 🔧 การติดตั้งและรัน

### ความต้องการระบบ
- Flutter SDK
- Dart SDK
- Android Studio / VS Code

## 🚀 คุณสมบัติพิเศษ

### ระบบกรองข้อมูล
- กรองตามประเภทธุรกรรม
- กรองตามหมวดหมู่
- กรองตามช่วงเวลา
- รวมตัวกรองหลายแบบ
- แสดงสรุปตัวกรองที่เลือก

### การจัดการข้อมูล
- เพิ่ม/แก้ไข/ลบธุรกรรม
- คำนวณยอดคงเหลือแบบ Real-time
- จัดเรียงตามวันที่อัตโนมัติ
- จัดกลุ่มตามวันที่

## 🎯 การพัฒนาต่อ

แอพนี้มีพื้นฐานที่แข็งแกร่งสำหรับการพัฒนาต่อ เช่น:
- ระบบ Multi-wallet
- การส่งออกข้อมูล
- กราฟและรายงาน
- การตั้งเป้าหมายการออม
- การแจ้งเตือน

## 👨‍💻 ผู้พัฒนา

[Apisit250aps](https://github.com/Apisit250aps)

## ใบอนุญาต

ซอฟต์แวร์นี้ใช้สัญญาอนุญาตแบบ MIT  
ดูรายละเอียดได้ที่ไฟล์ [LICENSE](LICENSE)


---

**Saving Quests** - เริ่มต้นการออมเงินแบบสมาร์ทไปกับเรา! 🎯💰
