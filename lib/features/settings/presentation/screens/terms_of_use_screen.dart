import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/core/theme/app_text_styles.dart';
import 'package:deduzai/core/widgets/deduzai_app_bar.dart';
import 'package:flutter/material.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final outline = Theme.of(context).colorScheme.onSurfaceVariant;

    return Scaffold(
      appBar: const DeduzaiAppBar(title: 'Termos de Uso'),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _section(
            'Aceitação dos termos',
            'Ao utilizar o DeduzAí, você concorda com estes '
                'Termos de Uso. Se não concordar com algum dos termos, '
                'recomendamos que não utilize o aplicativo.',
            outline,
          ),
          _section(
            'Finalidade do aplicativo',
            'O DeduzAí é uma ferramenta de organização pessoal '
                'para registro e acompanhamento de gastos que podem ser '
                'dedutíveis na declaração anual do Imposto de Renda '
                '(modelo completo). O aplicativo auxilia na categorização '
                'e totalização das despesas ao longo do ano fiscal.',
            outline,
          ),
          _section(
            'Isenção de responsabilidade',
            'O DeduzAí não presta consultoria tributária, '
                'contábil ou jurídica. As informações exibidas no '
                'aplicativo (categorias, limites de dedução, dicas) são '
                'de caráter informativo e não substituem o '
                'acompanhamento de um profissional qualificado.\n\n'
                'O usuário é o único responsável pela veracidade e '
                'precisão dos dados inseridos e pela correta declaração '
                'junto à Receita Federal.',
            outline,
          ),
          _section(
            'Responsabilidade do usuário',
            'Ao utilizar o aplicativo, você se compromete a:\n'
                '• Inserir informações verdadeiras e precisas\n'
                '• Manter cópias de segurança dos seus dados\n'
                '• Guardar os comprovantes originais conforme exigido '
                'pela legislação\n'
                '• Não utilizar o aplicativo para fins ilícitos',
            outline,
          ),
          _section(
            'Propriedade intelectual',
            'O DeduzAí, incluindo sua marca, design, código-fonte '
                'e conteúdo, é protegido por leis de propriedade '
                'intelectual. É proibida a reprodução, distribuição ou '
                'modificação não autorizada do aplicativo.',
            outline,
          ),
          _section(
            'Disponibilidade',
            'O DeduzAí é fornecido "como está" (as is), sem '
                'garantias de qualquer tipo. Não garantimos que o '
                'aplicativo estará livre de erros ou disponível '
                'ininterruptamente.',
            outline,
          ),
          _section(
            'Limitação de responsabilidade',
            'Em nenhuma hipótese o DeduzAí será responsável por '
                'danos diretos, indiretos ou consequenciais decorrentes '
                'do uso do aplicativo, incluindo, mas não se limitando a, '
                'perdas financeiras, multas fiscais ou perda de dados.',
            outline,
          ),
          _section(
            'Alterações nos termos',
            'Estes Termos de Uso podem ser atualizados '
                'periodicamente. O uso continuado do aplicativo após '
                'alterações constitui aceitação dos novos termos.',
            outline,
          ),
          _section(
            'Legislação aplicável',
            'Estes Termos de Uso são regidos pelas leis da '
                'República Federativa do Brasil.',
            outline,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Última atualização: março de 2026',
            style: AppTextStyles.labelMedium.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  Widget _section(String title, String body, Color subtitleColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(
            body,
            style: AppTextStyles.bodyMedium.copyWith(color: subtitleColor),
          ),
        ],
      ),
    );
  }
}
