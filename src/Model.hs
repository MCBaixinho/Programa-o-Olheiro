-- | Model.hs
-- Tipos de dados do domínio: jogadores, equipas, jogos e estatísticas.
module Model where

-- | Posição em campo de um jogador.
data Posicao = GuardaRedes | Defesa | Medio | Avancado
  deriving (Show, Eq)

-- | Um jogador do torneio. O 'jId' identifica-o de forma única.
data Jogador = Jogador
  { jId      :: Int
  , jNome    :: String
  , jEquipa  :: String
  , jPosicao :: Posicao
  } deriving (Show, Eq)

-- | Uma equipa e o seu plantel.
data Equipa = Equipa
  { eNome      :: String
  , eJogadores :: [Jogador]
  } deriving (Show, Eq)

-- | Estatísticas individuais de UM jogador em UM jogo.
-- O jogador é referenciado pelo id (spJogador = jId).
data StatsPartida = StatsPartida
  { spJogador     :: Int
  , spMinutos     :: Int
  , spGolos       :: Int
  , spAssist      :: Int
  , spRemates     :: Int
  , spEnquadrados :: Int
  , spPassesTent  :: Int
  , spPassesComp  :: Int
  , spDesarmes    :: Int
  , spFaltas      :: Int
  , spAmarelos    :: Int
  , spVermelhos   :: Int
  } deriving (Show, Eq)

-- | Estatísticas coletivas de UMA equipa em UM jogo.
-- Cantos e foras de jogo são lances da equipa, não de um jogador.
data StatsEquipa = StatsEquipa
  { seCantos      :: Int
  , seForasDeJogo :: Int
  } deriving (Show, Eq)

-- | Fase do torneio (formato eliminatório).
data Fase = Quartos | Meias | Final
  deriving (Show, Eq, Ord, Enum, Bounded)

-- | Um jogo do torneio.
-- O resultado NÃO é guardado: calcula-se somando os golos dos jogadores
-- em 'jgStats', para evitar dados duplicados e inconsistentes.
data Jogo = Jogo
  { jgId        :: Int
  , jgFase      :: Fase
  , jgCasa      :: Equipa
  , jgFora      :: Equipa
  , jgStatsCasa :: StatsEquipa
  , jgStatsFora :: StatsEquipa
  , jgStats     :: [StatsPartida]
  } deriving (Show, Eq)

-- | O torneio completo: 8 equipas e os jogos disputados.
data Torneio = Torneio
  { tEquipas :: [Equipa]
  , tJogos   :: [Jogo]
  } deriving (Show, Eq)
