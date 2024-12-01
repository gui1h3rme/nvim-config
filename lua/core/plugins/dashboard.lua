
local logo = [[
                                                                                                                                                
                                                                                                                                                
                                                                                                                                                
                                 -###                                                                                                           
                               ########                                                                                                         
                              ### ##### .+                                                                                                      
                              ##  ######.  ++-                                                                                                  
                             ###      +#####  +                                                                                                 
                             ###      ++#++### +++++                                                                                            
                              ##     .++-#  ###      ++                                                                                         
                           + ###     .++-##  ######### +                                                                                        
                           + ##.      +++###  ##########                                                                                        
                           + +##      ++-++#  #-########                                                                                        
                           ++ ##       ++++ ..-   .--+#####                                                                                     
                            + .##    +. ++  ......       .###                                                                                   
                            ++ ##-   .++++.++..  ###### +###                                                                                    
                             +  ##    .+++++  -##########+                                                                                      
                              + ###    .++++###+-+-+###                                                                                         
                              # #####    +++++++--++#####                                                                                       
                              + #######     -+++##++-######+  ++++.                                                                             
                                ###    ###      ++++-### ######    -+++++.                                                                      
                                ###     ++++++++++#+-##++-.  #######+     +++++#+                                                               
                                ###    .++------+-##+##-+-+++     #########-     ++++#+                                                         
                                ####    ++-----+-+####++#--+++++.       .########.    +++#                                                      
                                 ####   ++----+++####+++#------+++++-....      -+#####   ++++                                                   
                                  ####  .++--+++##+---++#---++++--+++++--.--#############   +++                                                 
                                   ######++-+-###+-++++#+---+++++---+-.           ######   +#++++                                               
                                    ##.  ++-+###+--+++-#-----# .+++-++++++++-.       +#####   +++++                                             
                                     ##. ++-+###-++++#-------#. ++++-------++++++  ..   #####   +                                               
                                   + ###  ++###++++++#-------#-   #++++------+-++++-+++    ####  +#                                             
                                   # +##  ++###-+++++#-------##      +++++++++----++++++++   ###  -#                                            
                                   +  ###  ++##-+++-+++------###        -++##++----------+++- +###  +                                           
                                   #- #### -+##--#++++#------+###        -#  +++-----------+++..###  +                                          
                                   -+  ####  +#####++++++----+####      +#    #+++++--+------+#+.+### +           ####+                         
                                    #+ .##### +####+-++++#+---#######   ##       #++++-------+.+######         ++   ++                          
                                     #+ -###########+-++++++#+-+##########          +#+++----++ #######     ++  ##       -++-                   
                                      #.  ############+++++++-##########+#  .          +++-+-+++  ####      ################  +                 
                                       #.  ###########-++++++##############   .          ++---+++   ##############      ########                
                                       ++   ###########+++++-+###########+##   ..         ++--##-++     ..   .+           ###+                  
                                        +#  ###########-++++++######+#########    -        +++##+-+++     .. -  +            ##+                
                                         ++  #+########-+-++++##+  ##############    .     ++. ##+-+++++-..-++++       ######-##                
                                          +  ##########-#-++-+##      #############+       .+  .##-+----+++++-  ++  #############               
                                          #- ##########-#-#-+###     +.  #############.         ####-++++++--++++ ####   ++++  ##               
                                          +# ############-#++###       ++  ##############       ######-++-+++-- ###   ++                        
                                           - ############+#+-##         ++  ########  ####      ######################  ++#.                    
                                             ##################           #  #######+  ####  #  +###  ###########-   ++#                        
                                             ##################           +  ########    ### ## -##+    .     -++++#-                           
                                        -######################              ##+###+#     ##### -##                                             
                                       #######################              -########     #####  ##                                             
                                    #############################     ###############      #########                                            
                                    #############################   ################       #########                                            
                                    ################################################+###   #######+#                                            
                                    ##################################################.  ############                                           
                                   #################################################    #############                                           
                                ##################################################     #############                                            
                             +##############################################################################                                    
                           ###############################################################################                                      
                         ####################################################################################################                   
                        #######################################################################################################                 
                                                                                                                                                
                                              --+#################################################+-.                                           
                                                                                                                                                
                                                                                                                                                
                                                                                                                                                
                                                      ..                                              ..      .           +                     
                            #####   ####  #####  .#########   ####    #### ########### #########  ##########   #####  ####+                     
                            ######  ####  ##+## .####    --   ####    #### -+ ##### ++ ####-  .  #####   ####   ####+####                       
                            ##+#### ####  ##+## #####         ####.##+####    ####     ####      ####    ####   -#######.                       
                            ############  ##### ##+##  #####  #########+##    ####-    ########  ####    ####    #######                        
                            #### #######  ##+## ##+##  .#+##  #### .  ####    ####-    ####+     ####    ####   #########                       
                            ####  ######  ##+## .####   #+##  ####    ####    ####-    ####-     #####+######  ##### #####                      
                            ####   #####  #####   ##########  ####    ####    #####    #####      ##########  #####   #####                     
                                                                                                                                                
                                                                                                                                                
                                                                                                                                                
                                                                                                                                                
                                                                                                                                                
                                                                                                                                                
                                                                                                                                                
]]
require('dashboard').setup {
  config = {
    header = vim.split(string.rep('\n', 2) .. logo, '\n') ,
    center = {
      {
        icon = '',
        icon_hl = 'group',
        desc = 'description',
        desc_hl = 'group',
        key = 'shortcut key in dashboard buffer not keymap !!',
        key_hl = 'group',
        key_format = ' [%s]', -- `%s` will be substituted with value of `key`
        action = '',
      },
    },
    footer = {},
  }
}
