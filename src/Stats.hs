-- | Stats.hs
-- Funções puras sobre as estatísticas individuais dos jogadores.
-- Na Fase 1 usa-se apenas recursão explícita e pattern matching.
module Stats where

import Model

-- | Junta numa só lista os registos de estatísticas de todos os jogos.
todasStats :: [Jogo] -> [StatsPartida]
todasStats []     = []
todasStats (j:js) = jgStats j ++ todasStats js

-- | Total de golos de um jogador numa lista de registos.
totalGolos :: Int -> [StatsPartida] -> Int
totalGolos _ [] = 0
totalGolos i (s:ss)
  | spJogador s == i = spGolos s + totalGolos i ss
  | otherwise        = totalGolos i ss

-- | Total de assistências de um jogador.
totalAssist :: Int -> [StatsPartida] -> Int
totalAssist _ [] = 0
totalAssist i (s:ss)
  | spJogador s == i = spAssist s + totalAssist i ss
  | otherwise        = totalAssist i ss

-- | Total de minutos jogados por um jogador.
totalMinutos :: Int -> [StatsPartida] -> Int
totalMinutos _ [] = 0
totalMinutos i (s:ss)
  | spJogador s == i = spMinutos s + totalMinutos i ss
  | otherwise        = totalMinutos i ss

-- | Número de jogos em que o jogador tem registo.
contarJogos :: Int -> [StatsPartida] -> Int
contarJogos _ [] = 0
contarJogos i (s:ss)
  | spJogador s == i = 1 + contarJogos i ss
  | otherwise        = contarJogos i ss

-- | Passes (tentados, completos) de um jogador somados em todos os registos.
totalPasses :: Int -> [StatsPartida] -> (Int, Int)
totalPasses _ [] = (0, 0)
totalPasses i (s:ss)
  | spJogador s == i = (spPassesTent s + t, spPassesComp s + c)
  | otherwise        = (t, c)
  where (t, c) = totalPasses i ss

-- | Percentagem a partir de (parte, total). Devolve 0 se o total for 0.
percentagem :: Int -> Int -> Double
percentagem _ 0     = 0
percentagem parte total = 100 * fromIntegral parte / fromIntegral total

-- | Percentagem de passes completos num registo.
percentagemPasse :: StatsPartida -> Double
percentagemPasse s = percentagem (spPassesComp s) (spPassesTent s)

-- | Percentagem de remates enquadrados num registo.
percentagemEnquadrados :: StatsPartida -> Double
percentagemEnquadrados s = percentagem (spEnquadrados s) (spRemates s)

-- | Percentagem de passe de um jogador ao longo do torneio.
percentagemPasseTotal :: Int -> [StatsPartida] -> Double
percentagemPasseTotal i ss = percentagem comp tent
  where (tent, comp) = totalPasses i ss

-- | Procura um jogador pelo id.
procurarJogador :: Int -> [Jogador] -> Maybe Jogador
procurarJogador _ [] = Nothing
procurarJogador i (j:js)
  | jId j == i = Just j
  | otherwise  = procurarJogador i js

-- | Verifica se um jogador (pelo id) pertence a uma lista de jogadores.
pertence :: Int -> [Jogador] -> Bool
pertence _ []     = False
pertence i (j:js) = jId j == i || pertence i js

-- | Melhor marcador: jogador com mais golos (em empate fica o primeiro).
melhorMarcador :: [StatsPartida] -> [Jogador] -> Maybe (Jogador, Int)
melhorMarcador _ [] = Nothing
melhorMarcador ss (j:js) =
  case melhorMarcador ss js of
    Nothing -> Just (j, g)
    Just (j', g')
      | g >= g'   -> Just (j, g)
      | otherwise -> Just (j', g')
  where g = totalGolos (jId j) ss

-- | Melhor assistente: jogador com mais assistências.
melhorAssistente :: [StatsPartida] -> [Jogador] -> Maybe (Jogador, Int)
melhorAssistente _ [] = Nothing
melhorAssistente ss (j:js) =
  case melhorAssistente ss js of
    Nothing -> Just (j, a)
    Just (j', a')
      | a >= a'   -> Just (j, a)
      | otherwise -> Just (j', a')
  where a = totalAssist (jId j) ss

-- | Todos os jogadores de uma lista de equipas.
todosJogadores :: [Equipa] -> [Jogador]
todosJogadores []     = []
todosJogadores (e:es) = eJogadores e ++ todosJogadores es
