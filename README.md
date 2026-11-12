# Torneio de 8 Equipas: Estatísticas Individuais de Jogadores

Projeto semestral de **Programação Funcional** em Haskell.
**Fase atual: Fase 1 (modelação e núcleo funcional).**

Grupo: _[preencher]_ · Elementos: _[nomes e números]_

## Descrição

Sistema que regista as estatísticas de cada jogador (golos, assistências,
remates, passes, desarmes, faltas, cartões) e de cada equipa (cantos e
foras de jogo) em todos os jogos de um torneio eliminatório de 8 equipas:

    Quartos de final (4 jogos) -> Meias-finais (2 jogos) -> Final (1 jogo)

A partir desses registos, o programa calcula resultados, quem passa de
fase, o campeão, o melhor marcador, o melhor assistente, percentagens de
passe e totais de cantos e foras de jogo por equipa.

## Requisitos

- [GHCup](https://www.haskell.org/ghcup/), que instala o **GHC** e o **cabal**.

## Compilar e executar

Na pasta do projeto:

```bash
cabal build
cabal run
```

Para experimentar funções no interpretador:

```bash
cabal repl
```

```haskell
ghci> import DadosTeste
ghci> import Torneio
ghci> golosCasa jogo1
2
ghci> eNome <$> campeao torneio
Just "Baião"
```

## Estrutura

    torneio-stats/
    ├── README.md
    ├── cabal.project
    ├── torneio-stats.cabal
    ├── src/
    │   ├── Model.hs        -- tipos de dados do domínio
    │   ├── Stats.hs        -- estatísticas individuais (totais, %, melhores)
    │   ├── Torneio.hs      -- resultados, vencedores, fases, cantos/foras de jogo
    │   └── DadosTeste.hs   -- 8 equipas e 7 jogos fictícios
    ├── app/
    │   └── Main.hs         -- demonstração no terminal
    ├── test/               -- testes (Fase 2)
    ├── data/               -- ficheiros CSV (Fase 3)
    └── docs/               -- relatório

## Modelo de dados

| Tipo           | O que representa                                            |
|----------------|-------------------------------------------------------------|
| `Posicao`      | GuardaRedes, Defesa, Medio ou Avancado                      |
| `Jogador`      | id, nome, equipa e posição                                  |
| `Equipa`       | nome e lista de jogadores                                   |
| `StatsPartida` | estatísticas de um jogador num jogo                         |
| `StatsEquipa`  | cantos e foras de jogo de uma equipa num jogo               |
| `Fase`         | Quartos, Meias ou Final                                     |
| `Jogo`         | fase, equipas, estatísticas das equipas e dos jogadores     |
| `Torneio`      | equipas e jogos                                             |

Decisões principais:

- O **resultado não é guardado**: é calculado somando os golos dos jogadores,
  para que nunca haja um resultado diferente das estatísticas.
- **Estatísticas derivadas** (totais, percentagens, melhores) são sempre
  calculadas por funções puras e nunca guardadas.
- `Fase` e `Posicao` são **tipos algébricos**, o que impede valores inválidos.
- `StatsPartida` referencia o jogador pelo **id**.

## Funções da Fase 1

Todas são funções puras, escritas com **recursão explícita** e
**pattern matching**:

- `Stats`: `todasStats`, `totalGolos`, `totalAssist`, `totalMinutos`,
  `contarJogos`, `totalPasses`, `percentagemPasse`, `percentagemEnquadrados`,
  `percentagemPasseTotal`, `procurarJogador`, `pertence`, `melhorMarcador`,
  `melhorAssistente`, `todosJogadores`
- `Torneio`: `golosEquipa`, `golosCasa`, `golosFora`, `vencedor`, `emparelhar`,
  `jogosDaFase`, `vencedoresDe`, `faseSeguinte`, `campeao`, `cantosEquipa`,
  `forasDeJogoEquipa`, `jogosDisputados`, `totalCantos`

## Próximas fases

- **Fase 2:** reescrever as funções repetitivas com `map`, `filter`, folds e
  composição; rankings; validação dos dados com `Maybe`/`Either`; testes.
- **Fase 3:** leitura dos dados de ficheiros CSV, menu no terminal, relatório
  final gravado em ficheiro.
