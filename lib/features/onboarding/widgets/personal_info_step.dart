import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/onboarding_provider.dart';
import '../../../shared/models/onboarding_model.dart';

class PersonalInfoStep extends ConsumerStatefulWidget {
  const PersonalInfoStep({super.key});

  @override
  ConsumerState<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends ConsumerState<PersonalInfoStep> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    final data = ref.read(onboardingProvider).data;
    _nameController.text = data.name ?? '';
    _emailController.text = data.email ?? '';
    _selectedGender = data.gender;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          
          // 이름 입력
          _buildInputField(
            label: '이름',
            controller: _nameController,
            hintText: '현자들이 부를 이름을 알려주세요',
            isRequired: true,
            onChanged: (value) {
              ref.read(onboardingProvider.notifier).updatePersonalInfo(name: value);
            },
          ),
          
          const SizedBox(height: 24),
          
          // 이메일 입력 (선택사항)
          _buildInputField(
            label: '이메일',
            controller: _emailController,
            hintText: '알림을 받을 이메일 (선택사항)',
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              ref.read(onboardingProvider.notifier).updatePersonalInfo(email: value);
            },
          ),
          
          const SizedBox(height: 24),
          
          // 성별 선택
          _buildGenderSelection(),
          
          const SizedBox(height: 40),
          
          // 정보 안내
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.blue.withOpacity(0.3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue.shade300,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '입력하신 정보는 개인화된 조언을 위해서만 사용되며, 안전하게 보호됩니다.',
                    style: TextStyle(
                      color: Colors.blue.shade200,
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

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    bool isRequired = false,
    TextInputType? keyboardType,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isRequired) ...[
              const SizedBox(width: 4),
              const Text(
                '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
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

  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '성별',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '일부 현자들의 분석에 활용됩니다 (선택사항)',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          children: OnboardingOptions.genderOptions.map((gender) {
            final isSelected = _selectedGender == gender;
            return ChoiceChip(
              label: Text(gender),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedGender = selected ? gender : null;
                });
                ref.read(onboardingProvider.notifier).updatePersonalInfo(
                  gender: _selectedGender,
                );
              },
              selectedColor: Colors.amber.withOpacity(0.3),
              backgroundColor: Colors.white.withOpacity(0.1),
              labelStyle: TextStyle(
                color: isSelected ? Colors.amber : Colors.white,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              side: BorderSide(
                color: isSelected ? Colors.amber : Colors.white.withOpacity(0.3),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}