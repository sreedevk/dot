return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      pane_gap = 2, -- empty columns between vertical panes
      preset = {
        header = [[
                      :h-                                  Nhy`               
                     -mh.                           h.    `Ndho               
                     hmh+                          oNm.   oNdhh               
                    `Nmhd`                        /NNmd  /NNhhd               
                    -NNhhy                      `hMNmmm`+NNdhhh               
                    .NNmhhs              ```....`..-:/./mNdhhh+               
                     mNNdhhh-     `.-::///+++////++//:--.`-/sd`               
                     oNNNdhhdo..://++//++++++/+++//++///++/-.`                
                y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       
           .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        
           h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         
           hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`        
           /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.       
            oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.      
             /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     
               /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    
                 .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    
                 -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   
                 /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   
                 //+++//++++++////+++///::--                 .::::-------::   
                 :/++++///////////++++//////.                -:/:----::../-   
                 -/++++//++///+//////////////               .::::---:::-.+`   
                 `////////////////////////////:.            --::-----...-/    
                  -///://////////////////////::::-..      :-:-:-..-::.`.+`    
                   :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -   
                     ::::://::://::::::::::::::----------..-:....`.../- -+oo/ 
                      -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``
                     s-`::--:::------:////----:---.-:::...-.....`./:          
                    yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           
                   oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              
                  :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                
                                  .-:mNdhh:.......--::::-`                    
                                     yNh/..------..`                          
                                                                              
        ]],
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "e", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "/", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = "⑆ ", key = "g", desc = "Neogit Dash", action = ":Neogit<CR>" },
          { icon = " ", key = "o", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "p", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      }
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = false },
    image = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    { "<leader><space>", function() Snacks.picker.smart() end,           desc = "Smart Find Files" },
    { "<leader>bl",      function() Snacks.picker.buffers() end,         desc = 'Buffer List',     noremap = true },
    { "<leader>:",       function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>/",       function() Snacks.picker.grep() end,            desc = "Grep" },
    { "<C-n>",           function() Snacks.explorer() end,               desc = "Toggle Neotree" },
    { "<leader>ig",      function() Snacks.indent() end,                 desc = "Toggle Neotree" },
  },
}
