import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teacher/core/config/sharedPreferences_manager.dart';
import 'package:teacher/core/enums/shared_preferences_keys.dart';
import 'package:teacher/core/resource/colors_manager.dart';
import 'package:teacher/core/widgets/custom_appbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final _firstName = TextEditingController(text: SharedPreferencesManger.instance.getString(SharedPreferencesKeys.firstName)??'');
  final _lastName = TextEditingController(text: SharedPreferencesManger.instance.getString(SharedPreferencesKeys.lastName)??'');
  final _userCode = TextEditingController(text: SharedPreferencesManger.instance.getString(SharedPreferencesKeys.codeUser)??'');
  final _birthdayCtrl = TextEditingController(text: '22-10-2001');
  final _mobileCtrl = TextEditingController(text: SharedPreferencesManger.instance.getString(SharedPreferencesKeys.phoneNumber)??'');
  final _emailCtrl = TextEditingController(text: SharedPreferencesManger.instance.getString(SharedPreferencesKeys.email)??''); // كما في الصورة

  DateTime? _birthday;
  String _gender = 'Male';

  // الألوان المستخدمة في التصميم
  static const Color _bgGrey = Color(0xFFE8E8E8);
  static const Color _cardWhite = Colors.white;
  static const Color _borderGrey = Color(0xFFE7E7E7);
  static const Color _labelGrey = Color(0xFF9A9A9A);
  static const Color _textDark = Color(0xFF333333);
  static const Color _accentPink = Color(0xFFE88989);

  InputDecoration _input(String hint, {Widget? suffixIcon}) {
    final radius = BorderRadius.circular(28);
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _textDark, fontSize: 16),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      filled: true,
      fillColor: Colors.white,
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: _borderGrey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: _borderGrey, width: 1.2),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(
        color: _labelGrey,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    ),
  );

  Future<void> _pickBirthday() async {
    final now = DateTime.now();
    final initial = _birthday ?? DateTime(now.year - 18, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 1),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: _accentPink,
              secondary: _accentPink,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _birthday = picked;
        _birthdayCtrl.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _birthdayCtrl.dispose();
    _mobileCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // TODO: احفظ البيانات
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Saved')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: greenLight,
              shape: const StadiumBorder(),
              elevation: 0,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            child: const Text('Save'),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: _cardWhite,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                children: [
                  // AppBar داخل البطاقة
                CustomAppbar(title: 'تعذيل الملف الشخصي',showBackButton: true,),
                  const SizedBox(height: 12),

                  // First/Last name
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label('الاسم '),
                            TextFormField(
                              controller: _firstName,
                              decoration: _input('الاسم'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label('الكنية'),
                            TextFormField(
                              controller: _lastName,
                              decoration: _input('الكنية'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Birthday
                  _label('تاريخ الميلاد'),
                  TextFormField(
                    controller: _birthdayCtrl,
                    readOnly: true,
                    decoration: _input(
                      'dd-mm-yyyy',
                      suffixIcon: IconButton(
                        onPressed: _pickBirthday,
                        icon: const Icon(Icons.calendar_today_outlined),
                        color: greenLight,
                      ),
                    ),
                    onTap: _pickBirthday,
                  ),
                  const SizedBox(height: 18),

                  // Gender
                  _label('الجنس'),
                  DropdownButtonFormField<String>(
                    value: _gender,
                    items: const [
                      DropdownMenuItem(value: 'Male', child: Text('Male')),
                      DropdownMenuItem(value: 'Female', child: Text('Female')),
                    ],
                    onChanged: (v) => setState(() => _gender = v ?? 'Male'),
                    decoration: _input('Male'),
                    icon: const Icon(Icons.expand_more),
                  ),
                  const SizedBox(height: 18),

                  // Mobile Number
                  _label('الهاتف'),
                  TextFormField(
                    controller: _mobileCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: _input('999 999 999'),
                  ),
                  const SizedBox(height: 18),
                  _label('الكود '),
                  TextFormField(
                    controller: _userCode,
                    keyboardType: TextInputType.phone,
                    decoration: _input(' *** *** '),
                  ),
                  const SizedBox(height: 18),
                  // Email
                  _label('البريد الالكنروني'),
                  TextFormField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _input('name@email.com'),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
