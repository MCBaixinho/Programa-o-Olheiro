-- | DadosTeste.hs
-- Dados fictícios para demonstração: 8 equipas (3 jogadores cada, para
-- simplificar) e os 7 jogos do torneio (4 quartos, 2 meias, 1 final).
module DadosTeste where

import Model

-- ---------------------------------------------------------------------
-- Equipas e jogadores
-- ---------------------------------------------------------------------

porto, benfica, sporting, resende, amarante, baiao, braga, penafiel :: Equipa

porto = Equipa "Porto"
  [ Jogador 1 "João Pereira"     "Porto" Avancado
  , Jogador 2 "Miguel Santos"    "Porto" Medio
  , Jogador 3 "André Sousa"      "Porto" Defesa ]

benfica = Equipa "Benfica"
  [ Jogador 4 "Pedro Lima"       "Benfica" Avancado
  , Jogador 5 "Bruno Matos"      "Benfica" Medio
  , Jogador 6 "Nuno Faria"       "Benfica" Defesa ]

sporting = Equipa "Sporting"
  [ Jogador 7 "Diogo Neves"      "Sporting" Avancado
  , Jogador 8 "Hugo Ramos"       "Sporting" Medio
  , Jogador 9 "Filipe Costa"     "Sporting" Defesa ]

resende = Equipa "Resende"
  [ Jogador 10 "Ricardo Pinto"   "Resende" Avancado
  , Jogador 11 "Gonçalo Teixeira" "Resende" Medio
  , Jogador 12 "Luís Barbosa"    "Resende" Defesa ]

amarante = Equipa "Amarante"
  [ Jogador 13 "Marco Ferreira"  "Amarante" Avancado
  , Jogador 14 "Vasco Ribeiro"   "Amarante" Medio
  , Jogador 15 "Paulo Mendes"    "Amarante" Defesa ]

baiao = Equipa "Baião"
  [ Jogador 16 "Sérgio Pacheco"  "Baião" Avancado
  , Jogador 17 "Daniel Monteiro" "Baião" Medio
  , Jogador 18 "Fábio Cunha"     "Baião" Defesa ]

braga = Equipa "Braga"
  [ Jogador 19 "Rafael Lopes"    "Braga" Avancado
  , Jogador 20 "Simão Correia"   "Braga" Medio
  , Jogador 21 "José Antunes"    "Braga" Defesa ]

penafiel = Equipa "Penafiel"
  [ Jogador 22 "Carlos Vieira"   "Penafiel" Avancado
  , Jogador 23 "Henrique Dias"   "Penafiel" Medio
  , Jogador 24 "Leandro Rocha"   "Penafiel" Defesa ]

-- | As 8 equipas, pela ordem do sorteio dos quartos de final.
equipas :: [Equipa]
equipas = [porto, benfica, sporting, resende, amarante, baiao, braga, penafiel]

-- ---------------------------------------------------------------------
-- Jogos
-- Ordem dos campos em StatsPartida:
--   jogador minutos golos assist remates enquadrados
--   passesTent passesComp desarmes faltas amarelos vermelhos
-- StatsEquipa: cantos foras_de_jogo
-- ---------------------------------------------------------------------

-- Quartos de final ------------------------------------------------------

-- Porto 2-1 Benfica
jogo1 :: Jogo
jogo1 = Jogo 1 Quartos porto benfica (StatsEquipa 6 2) (StatsEquipa 4 3)
  [ StatsPartida 1 90 2 0 5 3 20 15 0 1 0 0
  , StatsPartida 2 90 0 2 1 0 50 45 3 2 1 0
  , StatsPartida 3 90 0 0 0 0 35 30 6 2 0 0
  , StatsPartida 4 90 1 0 4 2 15  9 1 0 0 0
  , StatsPartida 5 90 0 1 2 1 48 40 2 1 0 0
  , StatsPartida 6 90 0 0 0 0 30 24 5 3 1 0 ]

-- Sporting 3-0 Resende
jogo2 :: Jogo
jogo2 = Jogo 2 Quartos sporting resende (StatsEquipa 8 1) (StatsEquipa 2 4)
  [ StatsPartida  7 90 2 1 6 4 22 17 0 0 0 0
  , StatsPartida  8 90 1 1 3 2 55 50 2 1 0 0
  , StatsPartida  9 90 0 1 1 0 40 36 4 1 0 0
  , StatsPartida 10 90 0 0 2 0 18 11 1 2 1 0
  , StatsPartida 11 90 0 0 1 1 42 33 3 3 1 0
  , StatsPartida 12 75 0 0 0 0 25 19 4 4 1 1 ]

-- Amarante 1-2 Baião
jogo3 :: Jogo
jogo3 = Jogo 3 Quartos amarante baiao (StatsEquipa 5 2) (StatsEquipa 3 1)
  [ StatsPartida 13 90 1 0 4 2 19 13 0 1 0 0
  , StatsPartida 14 90 0 1 2 1 47 39 2 2 0 0
  , StatsPartida 15 90 0 0 0 0 33 28 5 2 1 0
  , StatsPartida 16 90 1 1 5 3 21 16 1 0 0 0
  , StatsPartida 17 90 1 0 2 2 44 37 3 1 0 0
  , StatsPartida 18 90 0 1 1 0 31 26 6 3 1 0 ]

-- Braga 2-0 Penafiel
jogo4 :: Jogo
jogo4 = Jogo 4 Quartos braga penafiel (StatsEquipa 7 2) (StatsEquipa 3 3)
  [ StatsPartida 19 90 1 1 4 3 24 19 0 1 0 0
  , StatsPartida 20 90 1 0 3 2 52 46 2 0 0 0
  , StatsPartida 21 90 0 1 0 0 38 34 4 2 0 0
  , StatsPartida 22 90 0 0 3 1 16 10 1 1 0 0
  , StatsPartida 23 90 0 0 1 0 40 31 2 2 1 0
  , StatsPartida 24 90 0 0 0 0 27 21 3 3 1 0 ]

-- Meias-finais ----------------------------------------------------------

-- Porto 1-2 Sporting
jogo5 :: Jogo
jogo5 = Jogo 5 Meias porto sporting (StatsEquipa 5 2) (StatsEquipa 4 2)
  [ StatsPartida 1 90 1 0 4 2 18 13 0 1 0 0
  , StatsPartida 2 90 0 1 1 1 49 42 2 2 0 0
  , StatsPartida 3 90 0 0 0 0 34 29 5 3 1 0
  , StatsPartida 7 90 1 0 5 3 20 15 1 0 0 0
  , StatsPartida 8 90 1 1 2 2 53 48 3 1 1 0
  , StatsPartida 9 90 0 1 0 0 41 37 4 2 0 0 ]

-- Baião 1-0 Braga
jogo6 :: Jogo
jogo6 = Jogo 6 Meias baiao braga (StatsEquipa 2 3) (StatsEquipa 9 1)
  [ StatsPartida 16 90 1 0 3 2 17 12 0 2 1 0
  , StatsPartida 17 90 0 1 1 0 45 38 4 1 0 0
  , StatsPartida 18 90 0 0 0 0 29 25 7 2 0 0
  , StatsPartida 19 90 0 0 5 2 23 18 1 1 0 0
  , StatsPartida 20 90 0 0 2 1 50 43 2 0 0 0
  , StatsPartida 21 90 0 0 0 0 36 31 3 2 1 0 ]

-- Final -----------------------------------------------------------------

-- Sporting 1-2 Baião
jogo7 :: Jogo
jogo7 = Jogo 7 Final sporting baiao (StatsEquipa 7 2) (StatsEquipa 3 2)
  [ StatsPartida  7 90 1 0 4 2 21 16 0 1 0 0
  , StatsPartida  8 90 0 1 3 1 51 44 2 2 1 0
  , StatsPartida  9 90 0 0 1 0 39 33 5 3 1 0
  , StatsPartida 16 90 1 1 4 3 19 14 1 1 0 0
  , StatsPartida 17 90 1 0 2 1 46 40 3 2 1 0
  , StatsPartida 18 90 0 1 0 0 32 27 6 1 0 0 ]

-- | O torneio completo.
torneio :: Torneio
torneio = Torneio equipas [jogo1, jogo2, jogo3, jogo4, jogo5, jogo6, jogo7]
