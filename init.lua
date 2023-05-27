function make_player_immortal(player, is_immortal)
    if is_immortal == true then
        player:set_hp(player:get_properties().hp_max * 2)
        player:set_armor_groups({immortal=1})
        minetest.chat_send_player(player:get_player_name(), "You're an immortal!")
    else
        player:set_hp(player:get_properties().hp_max)
        player:set_armor_groups({immortal=0})
        minetest.chat_send_player(player:get_player_name(), "You're a mortal!")
    end
end

minetest.register_privilege("immortal", {
    description = "Makes players immune to damage",
    give_to_singleplayer = false,
})

minetest.register_on_joinplayer(function(player)
    if minetest.check_player_privs(player:get_player_name(), {immortal=true}) then
        make_player_immortal(player, true)
    end
end)

minetest.register_on_priv_grant(function(name, granter, priv)
    if priv == "immortal" then
        local player = minetest.get_player_by_name(name)
        make_player_immortal(player, true)
    end
end)

minetest.register_on_priv_revoke(function(name, revoker, priv)
    if priv == "immortal" then
        local player = minetest.get_player_by_name(name)
        make_player_immortal(player, false)
    end
end)
