--[[A chess prototype built in lua curently in developement--]]
win_w = 650 --window width
win_h = 650 --windo hight
letters = {'a','b','c','d','e','f','g','h'}
function setUpBoard()
  --[[initilizes each space on the chess board--]]
  board = {
    ["a1"] = "R",
    ["b1"] = "N",
    ["c1"] = "B",
    ["d1"] = "Q",
    ["e1"] = "K",
    ["f1"] = "B",
    ["g1"] = "N",
    ["h1"] = "R",
    ["a8"] = "r",
    ["b8"] = "n",
    ["c8"] = "b",
    ["d8"] = "q",
    ["e8"] = "k",
    ["f8"] = "b",
    ["g8"] = "n",
    ["h8"] = "r",}
  for i = 1,8 do
    str = letters[i]
    board[str .. "2"] = "P"
    board[str .. "7"] = "p"
  end
  for j = 3,6 do
    for i = 1,8 do
      str = letters[i]
      board[str.. j] = " "
    end
  end
end

function checkSpace(x,y,c)
  --[[checks if a space is empty or has an enemy in it
  and that an that is in range of the board--]]
  if x > 0 and x < 9 and y > 0 and y < 9 then
    fp = board[letters[x] .. y]
    if (fp ~= fp:upper() or fp == ' ') and c == 'WHITE' then
      return {x,y}
    elseif (fp ~= fp:lower() or fp == ' ') and c == 'BLACK' then
      return {x,y}
    end
  end
  return nil
end

function getPossibleMoves(x,y,p)
  --[[returns all possible moves for the given piece--]]
  p_moves = {}
  c = 'BLACK'
  if board[letters[x] .. y] == board[letters[x] .. y]:upper() then
    c = 'WHITE'
  end
  if p == 'P' then
    if y < 8 then
      if(board[letters[x] .. y+1] == ' ') then
        table.insert(p_moves, {x,y+1})
        if y == 2 then
          if(board[letters[x] .. y+2] == ' ') then
            table.insert(p_moves, {x,y+2})
          end
        end
      end
      if x < 8 then
        fp = board[letters[x+1] .. y+1]
        if fp ~= ' ' and fp ~= fp:upper() then
          table.insert(p_moves, {x+1,y+1})
        end
      end
      if x > 1 and y < 8 then
        fp = board[letters[x-1] .. y+1]
        if fp ~= ' ' and fp ~= fp:upper() then
          table.insert(p_moves, {x-1,y+1})
        end
      end
    end
  elseif p == 'p' then
    space = checkSpace(x,y-1,c)
    fp = board[letters[x] .. y-1]
    if space ~= nil and fp == ' ' then
      table.insert(p_moves,space)
      space = checkSpace(x,y-2,c)
      fp = board[letters[x] .. y-2]
      if space ~= nil and fp == ' ' then
        table.insert(p_moves,space)
      end
    end
    if x+1 < 9 then
      space = checkSpace(x+1,y-1,c)
      fp = board[letters[x+1] .. y-1]
      if space ~= nil and fp ~= ' ' then
        table.insert(p_moves,space)
      end
    end
    space = checkSpace(x-1,y-1,c)
    if x-1 > 0 then
      fp = board[letters[x-1] .. y-1]
      if space ~= nil and fp ~= ' ' then
        table.insert(p_moves,space)
      end
    end
  elseif p == 'R' or p == 'r' then
    for i = x+1,8 do
      space = checkSpace(i,y,c)
      if space ~= nil then
        table.insert(p_moves,space)
        if board[letters[i] .. y] ~= ' ' then
          break
        end
      else
        break
      end
    end
    for i = x-1,1,-1 do
      space = checkSpace(i,y,c)
      if space ~= nil then
        table.insert(p_moves,space)
        if board[letters[i] .. y] ~= ' ' then
          break
        end
      else
        break
      end
    end
    for i = y+1,8 do
      space = checkSpace(x,i,c)
      if space ~= nil then
        table.insert(p_moves,space)
        if board[letters[x] .. i] ~= ' ' then
          break
        end
      else
        break
      end
    end
    for i = y-1,1,-1 do
      space = checkSpace(x,i,c)
      if space ~= nil then
        table.insert(p_moves,space)
        if board[letters[x] .. i] ~= ' ' then
          break
        end
      else
        break
      end
    end
  elseif p == 'N' or p == 'n' then
    space = checkSpace(x+1,y+2,c)
    if space ~= nil then
      table.insert(p_moves,space)
    end
    space = checkSpace(x+1,y-2,c)
    if space ~= nil then
      table.insert(p_moves,space)
    end
    space = checkSpace(x+2,y+1,c)
    if space ~= nil then
      table.insert(p_moves,space)
    end
    space = checkSpace(x+2,y-1,c)
    if space ~= nil then
      table.insert(p_moves,space)
    end
    space = checkSpace(x-1,y+2,c)
    if space ~= nil then
      table.insert(p_moves,space)
    end
    space = checkSpace(x-1,y-2,c)
    if space ~= nil then
      table.insert(p_moves,space)
    end
    space = checkSpace(x-2,y+1,c)
    if space ~= nil then
      table.insert(p_moves,space)
    end
    space = checkSpace(x-2,y-1,c)
    if space ~= nil then
      table.insert(p_moves,space)
    end
  elseif p == 'B' or p == 'b' then
    for i = 1,8 do
      space = checkSpace(x+i,y+i,c)
      if space ~= nil then
        table.insert(p_moves,space)
        if board[letters[x+i] .. y+i] ~= ' ' then
          break
        end
      else
        break
      end
    end
    for i = 1,8 do
      space = checkSpace(x-i,y-i,c)
      if space ~= nil then
        table.insert(p_moves,space)
        if board[letters[x-i] .. y-i] ~= ' ' then
          break
        end
      else
        break
      end
    end
    for i = 1,8 do
      space = checkSpace(x+i,y-i,c)
      if space ~= nil then
        table.insert(p_moves,space)
        if board[letters[x+i] .. y-i] ~= ' ' then
          break
        end
      else
        break
      end
    end
    for i = 1,8 do
      space = checkSpace(x-i,y+i,c)
      if space ~= nil then
        table.insert(p_moves,space)
        if board[letters[x-i] .. y+i] ~= ' ' then
          break
        end
      else
        break
      end
    end
  elseif p == 'Q' or p == 'q' then
    for i = x+1,8 do
      space = checkSpace(i,y,c)
      if space ~= nil then
        table.insert(p_moves,space)
        if board[letters[i] .. y] ~= ' ' then
          break
        end
      else
        break
      end
    end
    for i = x-1,1,-1 do
      space = checkSpace(i,y,c)
      if space ~= nil then
        table.insert(p_moves,space)
        if board[letters[i] .. y] ~= ' ' then
          break
        end
      else
        break
      end
    end
    for i = y+1,8 do
      space = checkSpace(x,i,c)
      if space ~= nil then
        table.insert(p_moves,space)
        if board[letters[x] .. i] ~= ' ' then
          break
        end
      else
        break
      end
    end
    for i = y-1,1,-1 do
      space = checkSpace(x,i,c)
      if space ~= nil then
        table.insert(p_moves,space)
        if board[letters[x] .. i] ~= ' ' then
          break
        end
      else
        break
      end
    end
    for i = 1,8 do
      space = checkSpace(x+i,y+i,c)
      if space ~= nil then
        table.insert(p_moves,space)
        if board[letters[x+i] .. y+i] ~= ' ' then
          break
        end
      else
        break
      end
    end
    for i = 1,8 do
      space = checkSpace(x-i,y-i,c)
      if space ~= nil then
        table.insert(p_moves,space)
        if board[letters[x-i] .. y-i] ~= ' ' then
          break
        end
      else
        break
      end
    end
    for i = 1,8 do
      space = checkSpace(x+i,y-i,c)
      if space ~= nil then
        table.insert(p_moves,space)
        if board[letters[x+i] .. y-i] ~= ' ' then
          break
        end
      else
        break
      end
    end
    for i = 1,8 do
      space = checkSpace(x-i,y+i,c)
      if space ~= nil then
        table.insert(p_moves,space)
        if board[letters[x-i] .. y+i] ~= ' ' then
          break
        end
      else
        break
      end
    end
  else
  end
  return p_moves
end

function returnMouseSquare(x,y)
  --[[converts x and y into board coordinates--]]
  x = x - win_h/10
  y = y - win_h/10
  if x > 0 and y > 0 then
    local tmp_x = math.floor(x/(win_h/10)+1)
    local tmp_y = math.floor(y/(win_h/10)+1)
    if tmp_x < 9 and tmp_y < 9 then
      tmp_y = 9 - tmp_y
      return tmp_x,tmp_y
    end
  end
  return nil
end

function love.load()
  --[[runs once on game start.
  sets up window and loads images--]]
  love.window.setMode(win_w, win_h)
  love.window.setTitle ("lua chess")
  setUpBoard()
  chess_pieces = {
    ["P"] = love.graphics.newImage('sprites/whitePawn.png'),
    ["R"] = love.graphics.newImage('sprites/whiteRook.png'),
    ["N"] = love.graphics.newImage('sprites/whiteKnight.png'),
    ["B"] = love.graphics.newImage('sprites/whiteBishop.png'),
    ["Q"] = love.graphics.newImage('sprites/whiteQueen.png'),
    ["K"] = love.graphics.newImage('sprites/whiteKing.png'),
    ["p"] = love.graphics.newImage('sprites/blackPawn.png'),
    ["r"] = love.graphics.newImage('sprites/blackRook.png'),
    ["n"] = love.graphics.newImage('sprites/blackKnight.png'),
    ["b"] = love.graphics.newImage('sprites/blackBishop.png'),
    ["q"] = love.graphics.newImage('sprites/blackQueen.png'),
    ["k"] = love.graphics.newImage('sprites/blackKing.png'),
  }
  chess_outlines = {
    ["P"] = love.graphics.newImage('sprites/pawnOutline.png'),
    ["R"] = love.graphics.newImage('sprites/rookOutline.png'),
    ["N"] = love.graphics.newImage('sprites/knightOutline.png'),
    ["B"] = love.graphics.newImage('sprites/bishopOutline.png'),
    ["Q"] = love.graphics.newImage('sprites/queenOutline.png'),
    ["K"] = love.graphics.newImage('sprites/kingOutline.png')
  }
end

function love.mousepressed(x,y,button)
  --[[function runs when mousebutton is pressed.
  allows the player to select a piece and move it--]]
  if button == 1 then
    local tmp_x,tmp_y = returnMouseSquare(x,y)
    if tmp_x ~= nil and board[letters[tmp_x] .. tmp_y] ~= ' ' and p_selected == false then
      p_selected = true
      sp_x = tmp_x
      sp_y = tmp_y
    elseif tmp_x ~= nil and p_selected == true then
      local fp = board[letters[sp_x] .. sp_y]
      v_moves = getPossibleMoves(sp_x,sp_y,fp)
      for i,v in pairs(v_moves) do
        if v[1] == tmp_x and v[2] == tmp_y then
          board[letters[sp_x] .. sp_y] = ' '
          board[letters[tmp_x] .. tmp_y] = fp
          break
        end
      end
      p_selected = false
      sp_x,sp_y = nil,nil
    else
      p_selected = false
      sp_x,sp_y = nil,nil
    end
  end
end

function love.update(dt)
  --[[runs every frame--]]
  local m_x,m_y = love.mouse.getPosition()
  local tmp_x,tmp_y = returnMouseSquare(m_x,m_y)
  if tmp_x ~= nil and p_selected == false then
    highlights = {}
    highlights = getPossibleMoves(tmp_x,tmp_y,board[letters[tmp_x] .. tmp_y])
  end
end

function love.draw()
  --[[draws the board and graphics every frame--]]
  love.graphics.setBackgroundColor(66/255,153/255,133/255)
  local r_size = win_h/10
  local font = love.graphics.newFont("arial_narrow_7.ttf", 48/(80/r_size))
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("fill", r_size-6, r_size-6, r_size*8+12, r_size*8+12)
  for i = 1,8 do
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(9-i,font,r_size-r_size/2,i*r_size+r_size/3)
    for j = 1,8 do
      if j%2 == i%2 then
        love.graphics.setColor(1/255, 182/255, 192/255)
      else
        love.graphics.setColor(208/255, 224/255, 255/255)
      end
      love.graphics.rectangle("fill", j*r_size, i*r_size, r_size, r_size)
      love.graphics.setColor(1, 1, 1)
      if board[letters[j] .. 9-i] ~= ' ' then
        love.graphics.draw(chess_pieces[board[letters[j] .. 9-i]],j*r_size,i*r_size,0,r_size/50,r_size/50)
      end
    end
  end
  love.graphics.setColor(1,1,1)
  if sp_x ~= nil then
    love.graphics.draw(chess_outlines[board[letters[sp_x] .. sp_y]:upper()],sp_x*r_size,(9-sp_y)*r_size,0,r_size/50,r_size/50)
  end
  love.graphics.setColor(0/255, 217/255, 56/255,0.8)
  if highlights ~= nil then
    for i,v in pairs(highlights) do
      love.graphics.circle("fill",v[1]*r_size+r_size/2,(9-v[2])*r_size+r_size/2, r_size/4)
    end
  end
  love.graphics.setColor(0, 0, 0)
  for j = 1,8 do
    love.graphics.print(letters[j],font,j*r_size+r_size/3,r_size*9.2)
  end
end
