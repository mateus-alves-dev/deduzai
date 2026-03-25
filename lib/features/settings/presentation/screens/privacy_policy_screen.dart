import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/core/theme/app_text_styles.dart';
import 'package:deduzai/core/widgets/deduzai_app_bar.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final outline = Theme.of(context).colorScheme.onSurfaceVariant;

    return Scaffold(
      appBar: const DeduzaiAppBar(title: 'Política de Privacidade'),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _section(
            'Introdução',
            'O DeduzAí é um aplicativo para registro e '
                'acompanhamento de gastos dedutíveis no Imposto de Renda. '
                'Levamos a sua privacidade a sério e estamos comprometidos '
                'com a proteção dos seus dados pessoais, em conformidade '
                'com a Lei Geral de Proteção de Dados (LGPD — Lei nº '
                '13.709/2018).',
            outline,
          ),
          _section(
            'Dados coletados',
            'O aplicativo coleta e armazena localmente no seu '
                'dispositivo as seguintes informações:\n'
                '• Descrição e valores de despesas dedutíveis\n'
                '• Categorias de dedução (saúde, educação, etc.)\n'
                '• Datas das despesas\n'
                '• Imagens de comprovantes fiscais\n'
                '• Preferências de configuração (notificações)',
            outline,
          ),
          _section(
            'Armazenamento local',
            'Todos os seus dados são armazenados exclusivamente no '
                'seu dispositivo, utilizando um banco de dados local '
                '(SQLite). Nenhum dado é enviado para servidores externos. '
                'O aplicativo funciona inteiramente offline.',
            outline,
          ),
          _section(
            'Compartilhamento de dados',
            'O DeduzAí não compartilha, vende ou transfere seus '
                'dados pessoais para terceiros. As informações permanecem '
                'sob seu controle total no dispositivo.',
            outline,
          ),
          _section(
            'Retenção de dados',
            'Os comprovantes e registros de despesas são mantidos '
                'enquanto o aplicativo estiver instalado. Recomendamos '
                'manter os comprovantes por no mínimo 5 anos, conforme '
                'exigência da Receita Federal para comprovação de '
                'deduções no Imposto de Renda.',
            outline,
          ),
          _section(
            'Seus direitos (LGPD)',
            'Conforme a LGPD, você tem direito a:\n'
                '• Acessar todos os seus dados armazenados\n'
                '• Corrigir dados incompletos ou desatualizados\n'
                '• Excluir seus dados a qualquer momento\n'
                '• Exportar seus dados\n\n'
                'Como os dados são armazenados localmente, você exerce '
                'esses direitos diretamente pelo aplicativo ou ao '
                'desinstalá-lo.',
            outline,
          ),
          _section(
            'Segurança',
            'A segurança dos seus dados depende das medidas de '
                'proteção do seu dispositivo (senha, biometria, '
                'criptografia de disco). Recomendamos manter seu '
                'dispositivo protegido com senha ou biometria.',
            outline,
          ),
          _section(
            'Alterações nesta política',
            'Esta política pode ser atualizada periodicamente. '
                'Alterações relevantes serão comunicadas por meio de '
                'atualizações do aplicativo.',
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
