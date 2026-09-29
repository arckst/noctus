# Noctus Pixel

Site local criado a partir do fundo, logotipo e fonte fornecidos.

## Abrir

Dê dois cliques em `../ABRIR-NOCTUS.cmd` ou, no PowerShell nesta pasta, execute `./INICIAR.ps1`. Abra o endereço Local exibido (normalmente http://localhost:5173). Mantenha o terminal aberto enquanto usa o site. As dependências e o banco local já estão preparados nesta máquina. O iniciador também reconhece o Node.js incluído no Codex nesta máquina.

## Administrador

O login é **LexBk**. A senha aleatória está em **../ACESSO-ADMINISTRADOR.txt**, fora dos arquivos públicos do projeto. Entre em `/conta`, adicione seu e-mail e altere a senha. O painel fica em `/admin`.

O quadro público contém LexBk e Kewzi. Adicionar alguém ao quadro da equipe não cria uma conta administrativa nem concede permissões. Somente LexBk recebeu acesso administrativo inicial.

## Incluído

- Cadastro com nickname, e-mail e senha; login e logout com sessões no servidor.
- Alteração de perfil e senha, com confirmação pela senha atual e invalidação das outras sessões.
- Skin pública por nickname via Skin Render, com imagem alternativa quando indisponível. A skin não comprova titularidade da conta Minecraft. Documentação: https://skinrender.dev/minecraft-avatar-api/
- Ncois em múltiplos de 1.000: R$ 0,50 por 1.000; VIP mensal R$ 30, anual R$ 330 e permanente R$ 3.000.
- Preços calculados no servidor e pedidos idempotentes. Nenhum pagamento ou entrega é simulado.
- Administração de staff e blog, com criação, edição e exclusão.
- Atendimento privado por chamado com chat persistente; respostas atualizadas a cada quatro segundos enquanto a conversa está aberta. Não há bot respondendo pelo staff.
- Regras próprias e versão inicial dos termos e privacidade.
- Layout responsivo e cópia do IP jogar.noctuspixel.com.

## Dados locais

O banco SQLite/D1 fica em `.wrangler/state`, fora dos arquivos públicos e ignorado pelo Git. Preserve essa pasta para manter contas, pedidos e conversas. Faça backup com o servidor parado. O arquivo `.sites-runtime/seed.sql` contém somente hash da senha e dados iniciais; não execute novamente no mesmo banco. A senha em texto está apenas no arquivo de entrega privado.

## Hospedagem e integrações pendentes

A publicação por Sites foi bloqueada porque a conta atingiu o limite de novos sites. Nenhum site remoto foi criado, e não foi alterado o acesso a sites existentes. `.openai/hosting.json` ainda não contém project_id. O banco, os usuários e a senha entregues são locais, não de produção.

Conforme solicitado, o provedor de pagamentos será integrado depois. Os pedidos ficam com status `awaiting_integration`; não existe botão para marcá-los como pagos. Para ativar vendas, conectar checkout com webhook validado, conciliação e entrega idempotente ao servidor Minecraft. Definir benefícios do VIP e condições da modalidade permanente antes das vendas. Não há renovação automática.

Antes da abertura pública: informar responsável e contato de privacidade, prazos de retenção, condições comerciais e processo de cancelamento; configurar domínio/HTTPS, proteção antiabuso na borda, backup, envio/verificação de e-mail e recuperação de senha. Hoje a alteração de senha exige conhecer a senha atual. O site não comprova a posse do nickname Minecraft.

A página de regras citada pelo usuário não estava acessível na consulta. O texto entregue é original e não foi apresentado como cópia/adaptação verificada daquela página.

## Desenvolvimento

Stack: React, TypeScript, Vinext/Vite, Cloudflare Worker e D1, componentes Radix/Shadcn.

Em outra máquina com Node.js >=22.13 e npm:

1. `npm ci`
2. `npm run build`
3. Aplique a migração em `drizzle/0000_reflective_impossible_man.sql` ao banco local via Wrangler conforme abaixo.
4. Gere um administrador local com `node scripts/create-local-admin.mjs` somente se ainda não houver credenciais no diretório pai; aplique `.sites-runtime/seed.sql` uma única vez.
5. `npm run dev`

Migração local: `node --import ./scripts/sites-env.mjs ./node_modules/wrangler/bin/wrangler.js d1 execute DB --local --config dist/server/wrangler.json --persist-to .wrangler/state --file drizzle/0000_reflective_impossible_man.sql`

Seed local: substitua o arquivo da migração por `.sites-runtime/seed.sql` no comando anterior. Nunca execute o seed local em um banco de produção existente.

## Validação

Build de produção e verificação TypeScript. Testes de integração cobrem 30 verificações de autenticação, preços, idempotência de pedidos, permissões administrativas, isolamento de suporte, troca de senha, revogação de sessão e bloqueio de origem externa. Contas de teste são removidas após a validação.


## Página Launcher

A rota `/launcher` está no menu principal e oferece o Noctus Launcher 1.1.0 para Windows. O botão baixa as partes do pacote, verifica tamanho e SHA-256 e salva um único ZIP. Os assets foram divididos para permanecer abaixo do limite por arquivo da hospedagem. O pacote é idêntico a `../Noctus-Launcher-Windows.zip`. A página inclui instruções e tratamento de falhas/repetição de download.

Em 29/09/2026, novas tentativas de publicação, após o usuário excluir sites, continuaram bloqueadas por `site_hosting_usage_limit_reached` (HTTP 429). A resposta informa limite de uso até a renovação, não confirma vaga liberada. Nenhum site remoto Noctus foi criado.
