-- | Main.hs
-- Demonstração da Fase 1: corre as funções do núcleo sobre os dados de
-- teste e mostra os resultados no terminal.
module Main where

import Model
import Stats
import Torneio
import DadosTeste
import System.IO (hSetEncoding, stdout, utf8)

main :: IO ()
main = do
  hSetEncoding stdout utf8   -- para os acentos aparecerem bem (ex.: Windows)
  putStrLn "=== Torneio de 8 Equipas: Estatísticas (Fase 1) ==="

  putStrLn "\n--- Resultados ---"
  putStr (unlines (linhasResultados (tJogos torneio)))

  putStrLn "\n--- Quem passou dos quartos ---"
  putStrLn (nomes (vencedoresDe (jogosDaFase Quartos (tJogos torneio))))

  putStrLn "\n--- Emparelhamento das meias (a partir dos vencedores) ---"
  putStr (unlines (linhasPares (emparelhar (vencedoresDe (jogosDaFase Quartos (tJogos torneio))))))

  putStrLn "\n--- Campeão ---"
  putStrLn (maybe "Sem campeão (final em falta ou empatada)" eNome (campeao torneio))

  let stats     = todasStats (tJogos torneio)
      jogadores = todosJogadores (tEquipas torneio)

  putStrLn "\n--- Destaques individuais ---"
  putStrLn ("Melhor marcador:   " ++ destaque (melhorMarcador stats jogadores) "golos")
  putStrLn ("Melhor assistente: " ++ destaque (melhorAssistente stats jogadores) "assistências")

  putStrLn "\n--- Ficha de um jogador (id 7) ---"
  putStr (unlines (fichaJogador 7 jogadores stats))

  putStrLn "\n--- Cantos e foras de jogo por equipa ---"
  putStr (unlines (linhasEquipas (tEquipas torneio) (tJogos torneio)))
  putStrLn ("Total de cantos no torneio: " ++ show (totalCantos (tJogos torneio)))

-- ---------------------------------------------------------------------
-- Funções auxiliares de apresentação (transformam dados em texto)
-- ---------------------------------------------------------------------

linhasResultados :: [Jogo] -> [String]
linhasResultados [] = []
linhasResultados (j:js) =
  (show (jgFase j) ++ ": " ++ eNome (jgCasa j) ++ " " ++ show (golosCasa j)
     ++ "-" ++ show (golosFora j) ++ " " ++ eNome (jgFora j))
  : linhasResultados js

linhasPares :: [(Equipa, Equipa)] -> [String]
linhasPares [] = []
linhasPares ((a, b):ps) = (eNome a ++ " vs " ++ eNome b) : linhasPares ps

nomes :: [Equipa] -> String
nomes []     = ""
nomes [e]    = eNome e
nomes (e:es) = eNome e ++ ", " ++ nomes es

destaque :: Maybe (Jogador, Int) -> String -> String
destaque Nothing _       = "sem dados"
destaque (Just (j, n)) o = jNome j ++ " (" ++ jEquipa j ++ ") - " ++ show n ++ " " ++ o

fichaJogador :: Int -> [Jogador] -> [StatsPartida] -> [String]
fichaJogador i js ss =
  case procurarJogador i js of
    Nothing -> ["Jogador " ++ show i ++ " não encontrado"]
    Just j ->
      [ "Nome:         " ++ jNome j ++ " (" ++ jEquipa j ++ ", " ++ show (jPosicao j) ++ ")"
      , "Jogos:        " ++ show (contarJogos i ss)
      , "Minutos:      " ++ show (totalMinutos i ss)
      , "Golos:        " ++ show (totalGolos i ss)
      , "Assistências: " ++ show (totalAssist i ss)
      , "Passe:        " ++ show (arredondar (percentagemPasseTotal i ss)) ++ "%"
      ]

linhasEquipas :: [Equipa] -> [Jogo] -> [String]
linhasEquipas [] _ = []
linhasEquipas (e:es) jogos =
  (eNome e ++ ": " ++ plural (jogosDisputados n jogos) "jogo" ++ ", "
     ++ show (cantosEquipa n jogos) ++ " cantos, "
     ++ show (forasDeJogoEquipa n jogos) ++ " foras de jogo")
  : linhasEquipas es jogos
  where n = eNome e

-- | "1 jogo", "3 jogos".
plural :: Int -> String -> String
plural 1 palavra = "1 " ++ palavra
plural n palavra = show n ++ " " ++ palavra ++ "s"

-- | Arredonda a 1 casa decimal.
arredondar :: Double -> Double
arredondar x = fromIntegral (round (x * 10) :: Int) / 10
