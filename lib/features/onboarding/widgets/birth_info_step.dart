import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/onboarding_provider.dart';

class BirthInfoStep extends ConsumerStatefulWidget {
  const BirthInfoStep({super.key});

  @override
  ConsumerState<BirthInfoStep> createState() => _BirthInfoStepState();
}

class _BirthInfoStepState extends ConsumerState<BirthInfoStep> {
  final _birthTimeController = TextEditingController();
  final _birthPlaceController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    final data = ref.read(onboardingProvider).data;
    _selectedDate = data.birthDate;
    _birthTimeController.text = data.birthTime ?? '';
    _birthPlaceController.text = data.birthPlace ?? '';
  }

  @override
  void dispose() {
    _birthTimeController.dispose();
    _birthPlaceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          
          // 생년월일 선택
          _buildDatePicker(),
          
          const SizedBox(height: 24),
          
          // 출생 시간 입력
          _buildInputField(
            label: '출생 시간',
            controller: _birthTimeController,
            hintText: '예: 14:30 (선택사항)',
            onChanged: (value) {
              ref.read(onboardingProvider.notifier).updateBirthInfo(birthTime: value);
            },
          ),
          
          const SizedBox(height: 24),
          
          // 출생 장소 입력
          _buildInputField(
            label: '출생 장소',
            controller: _birthPlaceController,
            hintText: '예: 서울특별시 (선택사항)',
            onChanged: (value) {
              ref.read(onboardingProvider.notifier).updateBirthInfo(birthPlace: value);
            },
          ),
          
          const SizedBox(height: 40),
          
          // 정보 안내
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.purple.withOpacity(0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      color: Colors.purple.shade300,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '왜 출생 정보가 필요한가요?',
                      style: TextStyle(
                        color: Colors.purple.shade200,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '• 스텔라: 별자리와 행성 배치 분석\n'
                  '• 솔론: 사주명리학 기반 운세 해석\n'
                  '• 기타 현자들: 더 정확한 개인화 조언',
                  style: TextStyle(
                    color: Colors.purple.shade200,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 개인정보 보호 안내
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.green.withOpacity(0.3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lock_outline,
                  color: Colors.green.shade300,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '모든 정보는 암호화되어 안전하게 보관되며, 오직 개인화된 조언을 위해서만 사용됩니다.',
                    style: TextStyle(
                      color: Colors.green.shade200,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              '생년월일',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              '*',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _selectDate,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate != null
                      ? '${_selectedDate!.year}년 ${_selectedDate!.month}월 ${_selectedDate!.day}일'
                      : '생년월일을 선택해주세요',
                  style: TextStyle(
                    color: _selectedDate != null ? Colors.white : Colors.white.withOpacity(0.5),
                    fontSize: 16,
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  color: Colors.white.withOpacity(0.7),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.amber),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.amber,
              onPrimary: Colors.black,
              surface: Colors.grey.shade800,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      ref.read(onboardingProvider.notifier).updateBirthInfo(birthDate: picked);
    }
  }
}