return {
    Name = "tradehistory", 
    Aliases = {
        "th", 
        "trades", 
        "tradehistory"
    }, 
    Description = "Opens trading history (yours or another player's, including offline players). Use username or UserId (e.g., -2 for test)", 
    Group = "Admin", 
    Args = {
        {
            Type = "playerId", 
            Name = "Player", 
            Description = "The player (username or UserId like #-2) whose trade history to view (optional, defaults to yourself)"
        }
    }
};