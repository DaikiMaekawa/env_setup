--
-- .xmonad/xmonad.hs
--

-- インポート
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Actions.Volume
import XMonad.Util.Dzen
import Data.Map    (fromList)
import Data.Monoid (mappend)

------------------------------------------------------------------------
-- こまごました設定

-- ターミナルの指定
myTerminal      = "gnome-terminal"

-- modキーをWindowsに
myModMask       = mod4Mask

-- ワークスペース
myWorkspaces = ["1:work","2:web"] ++ map show [3..9]

-- Sound Control

alert = dzenConfig centered . show . round

centered =
        onCurr (center 150 66)
    >=> font "-*-helvetica-*-r-*-*-64-*-*-*-*-*-*-*"
    >=> addArgs ["-fg", "#80c0ff"]
    >=> addArgs ["-bg", "#000040"]

myKeys =  keys defaultConfig `mappend`
    \c -> fromList [
        ((0, xK_F6), lowerVolume 4 >>= alert),
        ((0, xK_F7), raiseVolume 4 >>= alert)
    ]

------------------------------------------------------------------------
-- xmobarの設定

-- Command to launch the bar.
myBar = "xmobar"

-- 表示の指定
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Keybinding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

------------------------------------------------------------------------
-- 設定の実行

-- 実行
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- 設定(上書きしなければデフォルトの値が用いられる)
myConfig = defaultConfig {
        terminal           = myTerminal,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        keys =  keys defaultConfig `mappend`
            \c -> fromList [
                ((0, xK_F6), lowerVolume 4 >>= alert),
                ((0, xK_F7), raiseVolume 4 >>= alert)
            ]
    }
