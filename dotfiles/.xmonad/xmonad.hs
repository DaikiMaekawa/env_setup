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
import XMonad.Layout.Spacing           -- this makes smart space around windows
import XMonad.Layout.ResizableTile     -- Resizable Horizontal border
import XMonad.Layout.DragPane          -- see only two window
import XMonad.Layout.ToggleLayouts     -- Full window at any time
import XMonad.Layout.NoBorders         -- In Full mode, border is no use
import XMonad.Hooks.ManageDocks        -- To enable avoidStruts 

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
        ((0, xK_F7), raiseVolume 4 >>= alert),

        -- Brightness Keys
        ((0, xK_F9), spawn "xbacklight + 10 -time 100 -steps 1"),
        ((0, xK_F8), spawn "xbacklight - 10 -time 100 -steps 1")
    ]

-- Handle Window behaveior

myLayout = (spacing 18 $ ResizableTall 1 (3/100) (3/5) [])
            |||  (spacing 2 $ (dragPane Horizontal (1/10) (1/2)))
            |||  (dragPane Vertical   (1/10) (1/2))

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
        keys = myKeys,
        layoutHook = toggleLayouts (noBorders Full) $ avoidStruts $ myLayout
        }
