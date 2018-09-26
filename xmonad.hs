import XMonad
import XMonad.Layout.Spacing
import XMonad.Layout.PerWorkspace
import XMonad.Layout.IM
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.Simplest
import XMonad.Layout.Fullscreen
import XMonad.Layout.Roledex
import XMonad.Layout.Reflect
import XMonad.Layout.TrackFloating
import XMonad.Layout.ComboP
import XMonad.Layout.TwoPane
import Data.Ratio ((%))
import qualified Data.Map as M
import Graphics.X11.ExtraTypes.XF86
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run
import XMonad.Actions.SpawnOn
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Tabbed
import qualified XMonad.StackSet as W
import XMonad.Actions.CycleWS
import XMonad.Actions.CycleRecentWS
import XMonad.Hooks.ManageHelpers
import System.IO
import XMonad.Util.SpawnOnce

-- HINTs 
-- * use xprop to figure out window name
-- * restart with MOD-Q

myWorkspaces = ["1","2","3","4","5","6","7","8","9","a:✉","s:☏","d:☺","f:⌂"]

myManageHook = composeAll
      [
      isDialog --> doFloat
      , className =? "Pidgin" --> doShift "d:☺"
      , className =? "chromium" --> doShift "s:☏"
      , className =? "Chromium" --> doShift "s:☏"
      , className =? "Thunderbird" --> doShift "a:✉"
      , className =? "Gnome-logs" --> doShift "f:⌂" 
      , className =? "Keepassx" --> doShift "f:⌂"
      , className =? "Wine" --> doFullFloat
      , className =? "sun-awt-X11-XDialogPeer" --> doFullFloat
      , className =? "jetbrains-idea-ce" <&&> appName =? "sun-awt-X11-XWindowPeer" --> doIgnore 
      --and wmName =? contains win343
      --[ appName =? "sun-awt-X11-XWindowPeer" <&&> className =?
      --"jetbrains-idea" --> doIgnore ]
      , className =? "Vlc" --> doFullFloat
      , role =? "AlarmWindow" --> doRectFloat(W.RationalRect 0.25 0.25 0.3 0.2)
      , className =? "Arandr" --> doCenterFloat
      , className =? "Pavucontrol" --> doRectFloat(W.RationalRect 0.25 0.25 0.5 0.5)
      , className =? "Pavucontrol" --> doRectFloat(W.RationalRect 0.25 0.25 0.5 0.5)
      , className =? "Blueman-manager" --> doRectFloat(W.RationalRect 0.25 0.25 0.5 0.5)
      ]
      where role = stringProperty "WM_WINDOW_ROLE"

keysToAdd x = [
              --,((mod4Mask, xK_Return), spawn "terminator")
               ((0, xF86XK_AudioMute), spawn "amixer -D pulse sset Master toggle")
              ,((0, xF86XK_AudioRaiseVolume), spawn "amixer -D pulse sset Master 5%+")
              ,((0, xF86XK_AudioLowerVolume), spawn "amixer -D pulse sset Master 5%-")
              --,((0, xF86XK_Display), spawn "scrot '/home/thoth/view/screen_capture/%Y_%m_%d_%H:%M:%S.png'")
              --,((0, xF86XK_AudioMicMute), spawn "amixer -c 0 -q set Master 2dB-")
              ,((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 5")
              ,((0, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 5")
              --,((0, xF86XK_Display), spawn "amixer -c 0 -q set Master 2dB-")
              --,((0, xF86XK_WLAN), spawn "amixer -c 0 -q set Master 2dB-")
              --,((0, xF86XK_Tools), spawn "amixer -c 0 -q set Master 2dB-")
              ,((0, xF86XK_LaunchA), spawn "i3lock -f -c 000000")
              ,((0, xF86XK_Explorer), spawn "systemctl suspend")
              ,((mod4Mask, xK_BackSpace), spawn "xterm ranger")
              --,((0, xF86XK_Tools), spawn "/usr/bin/togglexkbmap")
              ,((0, xF86XK_Tools), spawn "xmodmap ~/.Xmodmap")
              --,((0, xF86XK_MyComputer), spawn "amixer -c 0 -q set Master 2dB-")
              ,((mod4Mask, xK_a), (windows $ W.view "a:✉"))
              ,(((mod4Mask .|. shiftMask), xK_a), (windows $ W.shift "a:✉"))
              ,((mod4Mask, xK_s), (windows $ W.view "s:☏"))
              ,(((mod4Mask .|. shiftMask), xK_s), (windows $ W.shift "s:☏"))
              ,((mod4Mask, xK_d), (windows $ W.view "d:☺"))
              ,(((mod4Mask .|. shiftMask), xK_d), (windows $ W.shift "d:☺"))
              ,((mod4Mask, xK_f), (windows $ W.view "f:⌂"))
              ,(((mod4Mask .|. shiftMask), xK_f), (windows $ W.shift "f:⌂"))
              -- should learn some more haskell to do this right
              ,((mod4Mask, xK_1), (windows $ W.view "1"))
              ,((mod4Mask, xK_2), (windows $ W.view "2"))
              ,((mod4Mask, xK_3), (windows $ W.view "3"))
              ,((mod4Mask, xK_4), (windows $ W.view "4"))
              ,((mod4Mask, xK_5), (windows $ W.view "5"))
              ,((mod4Mask, xK_6), (windows $ W.view "6"))
              ,((mod4Mask, xK_7), (windows $ W.view "7"))
              ,((mod4Mask, xK_8), (windows $ W.view "8"))
              ,((mod4Mask, xK_9), (windows $ W.view "9"))
              ,(((mod4Mask), xK_w), nextScreen)
              --,((mod4Mask, xK_u), moveTo Next NonEmptyWS)
              --,((mod4Mask .|. shiftMask, xK_u), moveTo Prev NonEmptyWS)
              ,((mod4Mask, xK_i), moveTo Next EmptyWS)
              ,((mod4Mask, xK_Tab), nextWS)
              ,((mod4Mask .|. shiftMask, xK_Tab), prevWS)
              ,((mod4Mask .|. shiftMask, xK_Tab), prevWS)
              --,((mod4Mask, xK_Tab), cycleRecentWS [xK_Super_L] xK_Tab xK_grave)
              -- TODO: add forward version!
              ]

-- does not work?
keysToDel x = [((mod4Mask .|. shiftMask), xK_q)
              ,((mod4Mask), xK_Tab)
              ,((mod4Mask .|. shiftMask), xK_Tab)
              ,((mod4Mask), xK_w)
              ,((mod4Mask), xK_1)
              ,((mod4Mask), xK_2)
              ,((mod4Mask), xK_3)
              ,((mod4Mask), xK_4)
              ,((mod4Mask), xK_5)
              ,((mod4Mask), xK_6)
              ,((mod4Mask), xK_7)
              ,((mod4Mask), xK_8)
              ,((mod4Mask), xK_9)]
oldKeys x = foldr M.delete (keys defaultConfig x) (keysToDel x)
-- newKeys x = M.union (keys defaultConfig x) (M.fromList (keysToAdd x))
myKeys x = M.union (oldKeys x) (M.fromList (keysToAdd x))

--
myLayout = avoidStruts $ smartBorders (
           onWorkspace "1" stdlayout $ -- no idea, why this is necessary :(
           onWorkspace "9" movieLayout $
           onWorkspace "a:✉" mailLayout $
           onWorkspace "s:☏" webLayout $
           onWorkspace "d:☺" pidginLayout $
           onWorkspace "f:⌂" logLayout $
           stdlayout )
  where
     -- default tiling algorithm partitions the screen into two panes
     stdlayout = tiledTwo ||| noBorders Full 
     tiled   = Tall nmaster delta ratio
     tiledTwo   = Tall nmaster delta ratioGold
     -- The default number of windows in the master pane
     nmaster = 1
     -- Default proportion of screen occupied by master pane
     ratio   = 1/2
     ratioGold   = 2/(3.5)
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
     -- gridLayout = spacing 8 $ Grid
     pidginLayout = withIM (18/100) (Role "buddy_list") Grid
     movieLayout = noBorders Full
     -- mailLayout = simpleTabbed ||| tiledTwo
     -- mailLayout = combineTwoP (TwoPane 0.03 0.5) (Full) (simpleTabbed) (Role "3pane")
     mailLayout = withIM ratioGold (Role "3pane") (Grid ||| trackFloating simpleTabbed)
     webLayout = tiledTwo ||| Roledex ||| noBorders Full
     logLayout = withIM ratioGold (ClassName "Gnome-logs") tiled

myStartupHook = do
    spawnOnce "gnome-logs"
    spawnOnce "keepassx"
    spawnOnce "chromium"
    spawnOnce "pidgin"
    spawnOnce "thunderbird"

main = do
    xmonad =<< xmobar defaultConfig
        { terminal    = "/usr/bin/terminator"
        , workspaces = myWorkspaces
        , modMask     = mod4Mask
        , borderWidth = 3
        , manageHook = (isFullscreen --> doFullFloat) <+> (manageSpawn <+> myManageHook) <+> 
                       manageHook defaultConfig
        , layoutHook = myLayout
        , keys = myKeys
        , startupHook = myStartupHook
        }
