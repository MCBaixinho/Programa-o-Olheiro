-- | Torneio.hs
-- Lógica do torneio: resultados, vencedores, fases e estatísticas de equipa
-- (cantos e foras de jogo).
module Torneio where

import Model
import Stats (pertence)

-- | Golos marcados por uma equipa num jogo, somando os golos dos seus
-- jogadores nos registos do jogo.
golosEquipa :: Equipa -> [StatsPartida] -> Int
golosEquipa _ [] = 0
golosEquipa e (s:ss)
  | pertence (spJogador s) (eJogadores e) = spGolos s + golosEquipa e ss
  | otherwise                             = golosEquipa e ss

-- | Golos da equipa da casa.
golosCasa :: Jogo -> Int
golosCasa j = golosEquipa (jgCasa j) (jgStats j)

-- | Golos da equipa de fora.
golosFora :: Jogo -> Int
golosFora j = golosEquipa (jgFora j) (jgStats j)

-- | Vencedor de um jogo; Nothing em caso de empate.
vencedor :: Jogo -> Maybe Equipa
vencedor j
  | golosCasa j > golosFora j = Just (jgCasa j)
  | golosFora j > golosCasa j = Just (jgFora j)
  | otherwise                 = Nothing

-- | Emparelha equipas duas a duas (8 equipas -> 4 jogos).
emparelhar :: [Equipa] -> [(Equipa, Equipa)]
emparelhar (a:b:resto) = (a, b) : emparelhar resto
emparelhar _           = []

-- | Jogos de uma determinada fase.
jogosDaFase :: Fase -> [Jogo] -> [Jogo]
jogosDaFase _ [] = []
jogosDaFase f (j:js)
  | jgFase j == f = j : jogosDaFase f js
  | otherwise     = jogosDaFase f js

-- | Vencedores de uma lista de jogos (os empates são ignorados).
vencedoresDe :: [Jogo] -> [Equipa]
vencedoresDe [] = []
vencedoresDe (j:js) =
  case vencedor j of
    Just e  -> e : vencedoresDe js
    Nothing -> vencedoresDe js

-- | Fase seguinte, se existir.
faseSeguinte :: Fase -> Maybe Fase
faseSeguinte Quartos = Just Meias
faseSeguinte Meias   = Just Final
faseSeguinte Final   = Nothing

-- | Campeão: vencedor do (único) jogo da final, se existir.
campeao :: Torneio -> Maybe Equipa
campeao t =
  case jogosDaFase Final (tJogos t) of
    [final] -> vencedor final
    _       -> Nothing

-- | Total de cantos de uma equipa (pelo nome) em todos os jogos.
cantosEquipa :: String -> [Jogo] -> Int
cantosEquipa _ [] = 0
cantosEquipa n (j:js)
  | eNome (jgCasa j) == n = seCantos (jgStatsCasa j) + cantosEquipa n js
  | eNome (jgFora j) == n = seCantos (jgStatsFora j) + cantosEquipa n js
  | otherwise             = cantosEquipa n js

-- | Total de foras de jogo de uma equipa (pelo nome) em todos os jogos.
forasDeJogoEquipa :: String -> [Jogo] -> Int
forasDeJogoEquipa _ [] = 0
forasDeJogoEquipa n (j:js)
  | eNome (jgCasa j) == n = seForasDeJogo (jgStatsCasa j) + forasDeJogoEquipa n js
  | eNome (jgFora j) == n = seForasDeJogo (jgStatsFora j) + forasDeJogoEquipa n js
  | otherwise             = forasDeJogoEquipa n js

-- | Número de jogos disputados por uma equipa.
jogosDisputados :: String -> [Jogo] -> Int
jogosDisputados _ [] = 0
jogosDisputados n (j:js)
  | eNome (jgCasa j) == n || eNome (jgFora j) == n = 1 + jogosDisputados n js
  | otherwise                                      = jogosDisputados n js

-- | Total de cantos no torneio (as duas equipas, todos os jogos).
totalCantos :: [Jogo] -> Int
totalCantos []     = 0
totalCantos (j:js) = seCantos (jgStatsCasa j) + seCantos (jgStatsFora j) + totalCantos js
