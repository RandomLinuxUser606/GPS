# GPS - Gerenciador de pacotes simples
( O codigo e funcionalidade que é simples, não os pacotes, necessariamente)

Package manager educacional feito para aprender C e bash. Não use em produção.

## Arquitetura

O pakman funciona com um servidor HTTP local que hospeda pacotes e metadados. O cliente (este repo) baixa e instala binários em `/bin/` e bibliotecas em `/usr/lib/`.

### Componentes

- **main.c** - Interface principal em C que captura input do usuário e chama os scripts bash
- **verificar.sh** - Valida se pacote existe em `lista.txt` e faz download do binário
- **libs.sh** - Baixa e instala dependências (libs) do pacote
- **remove.sh** - Remove entrada do pacote em `logs.txt`
- **atualizar.sh** - Exibe conteúdo de `logs.txt` (pacotes instalados)
- **lista.txt** - Lista local de pacotes disponíveis
- **logs.txt** - Registro de pacotes instalados
- **pacote.txt** - Arquivo temporário que armazena nome do pacote sendo processado

## Instalação

### Dependências

- GCC (para compilar main.c)
- wget
- bash
- sudo/root access

### Setup do Servidor

O pakman espera um servidor HTTP rodando em `192.168.15.63:9999` com a seguinte estrutura:

```
/pacotes/       # Binários executáveis
/libs/          # Bibliotecas compartilhadas
/metadados/     # Diretórios com metadados de cada pacote
  /<pacote>/
    libs.txt    # Lista de bibliotecas necessárias
```

Você pode usar `python -m http.server 9999` ou qualquer servidor HTTP básico.
OBS: Os arquivos devem estar em .tar.xz, tirando aqueles que são .txt

### Compilação

```bash
gcc main.c -o gps.out
sudo mv pakman /usr/local/bin/  # ou qualquer dir no PATH
```

## Uso

```bash
./gps.out
```

### Comandos

- `I` - Instalar pacote
- `R` - Remover pacote

### Fluxo de Instalação

1. Digite `I` e o nome do pacote
2. O nome é salvo em `pacote.txt`
3. `verificar.sh` é executado:
   - Verifica se pacote existe em `lista.txt`
   - Faz wget do binário de `http://192.168.15.63:9999/pacotes/$PACOTE`
   - Move para `/bin/` com permissão de execução
   - Adiciona entrada em `logs.txt`
4. (Comentado) `libs.sh` baixaria dependências de `/metadados/$PACOTE/libs.txt`

### Fluxo de Remoção

1. Digite `R` e o nome do pacote
2. Remove o binário de `/bin/$PACOTE` usando `remove()`
3. `remove.sh` remove a entrada do pacote em `logs.txt` usando `sed`

## Configuração

### Mudar IP/Porta do Servidor

Edite `libs.sh` e `verificar.sh`:

```bash
# De:
wget http://192.168.15.63:9999/...

# Para:
wget http://<SEU_IP>:<SUA_PORTA>/...
```

### Lista de Pacotes

Edite `lista.txt` manualmente para adicionar/remover pacotes disponíveis:

```
fastfetch
btop
nome_do_pacote
```

## Estrutura de Dados

### logs.txt
```
Aqui esta o registro de todos os pacotes ja instalados
pacote1
pacote2
```

### pacote.txt (temporário)
```
nome_do_pacote
```

## Limitações Conhecidas

- Hardcoded IP/porta do servidor
- Sem verificação de checksum/hash
- Sem resolução automática de dependências
- `libs.sh` está comentado em `verificar.sh`
- Sem rollback em caso de falha
- Buffer overflow possível no `scanf("%20s", buff)` sem validação
- `remove()` em C não remove logs automaticamente (precisa rodar `remove.sh` após)
- Sem lock mechanism para instalações concorrentes

## Notas Técnicas

### main.c
- `buff[20]` - buffer para input do usuário (máx 19 chars + null terminator)
- `resp` - char que armazena opção I/R
- `caminho[]` - constrói path absoluto do binário em /bin/

### Scripts Bash
- Todos usam `$PACOTE` lendo de `pacote.txt`
- `sed -i` modifica `logs.txt` in-place
- `grep -Fx` busca linha exata em `lista.txt`

## TODO

- [ ] Implementar `atualizar.sh` para sync com servidor
- [ ] Ativar `libs.sh` e testar instalação de dependências
- [ ] Adicionar lock file para evitar conflitos
- [ ] Validação de checksum
- [ ] Log de erros separado
- [ ] Suporte a múltiplos repos

## License

GPL-3.0
