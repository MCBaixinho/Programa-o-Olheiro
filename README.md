# Torneio de 8 Equipas: Estatísticas Individuais de Jogadores

Projeto semestral de **Programação Funcional** em Haskell.
**Fase atual: Fase 1 (modelação e núcleo funcional).**

Grupo:  PLO3GR02  · Elementos: 

## Descrição

Sistema que regista as estatísticas de cada jogador (golos, assistências,
remates, passes, desarmes, faltas, cartões) e de cada equipa (cantos e
foras de jogo) em todos os jogos de um torneio eliminatório de 8 equipas:

    Quartos de final (4 jogos) -> Meias-finais (2 jogos) -> Final (1 jogo)

A partir desses registos, o programa calcula os resultados, quem passa de
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
