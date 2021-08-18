-- Skipper's Catalogue
-- GitHub: https://github.com/Vildravn/APICO-Skippers-Catalogue
--
-- A mod for APICO that adds a catalogue to order items from
-- Other mods can use this to get their custom items (e.g. custom workbenches) into an existing world without much hassle
-- Usage (user): Click Skipper's Boat to access the catalogue
-- Usage (modder):
--  1. Make sure your item has a shop_buy value defined. It can be 0 if you'd like, this is the cost of the item in the catalogue
--  2. Check whether the mod exists with api_mod_exists("skippers_catalogue")
--  3. Add an item to the catalogue by calling api_mod_call("skippers_catalogue", "catalogue_add_item", "[item_oid]")
--     The method will return "Success" if the item has been added and "nil" if it failed (most commonly due to the catalogue being full)
--     To add a log into the catalog, you'd call api_mod_call("skippers_catalogue", "catalogue_add_item", "log")

-- Global vars
-- Stores the instance ID of the catalogue menu object
catalogue_instance_id = nil

-- Stores the instance ID of the catalogue menu
catalogue_menu_id = nil

-- The text displayed in the catalogue menu UI
catalogue_text = "In this catalogue yah can find trinkets and bits I found in my travels to far away lands! If anythin' catches yer fancy, yer welcome to it for a price, hoho!\n- Skipper\n\n\n\n\n\n\n\nSkipper's Catalogue works like any other shop, selecting an item purchases it for the listed price."

function register()
    return {
        name = "skippers_catalogue",
        hooks = {"click"}
    }
end

function init()
    -- Define Skipper's Catalogue as a menu object
    api_define_menu_object({
        id = "catalogue",
        name = "Skipper's Catalogue",
        category = "Shopping",
        tooltip = "Purchase various items from the far away lands",
        shop_key = true,
        shop_buy = 0,
        shop_sell = 0,
        layout = {
            -- Row 1
            {167, 17, "Buy"},
            {189, 17, "Buy"},
            {211, 17, "Buy"},
            {233, 17, "Buy"},
            {255, 17, "Buy"},
            {277, 17, "Buy"},
            {299, 17, "Buy"},

            -- Row 2
            {167, 39, "Buy"},
            {189, 39, "Buy"},
            {211, 39, "Buy"},
            {233, 39, "Buy"},
            {255, 39, "Buy"},
            {277, 39, "Buy"},
            {299, 39, "Buy"},

            -- Row 3
            {167, 61, "Buy"},
            {189, 61, "Buy"},
            {211, 61, "Buy"},
            {233, 61, "Buy"},
            {255, 61, "Buy"},
            {277, 61, "Buy"},
            {299, 61, "Buy"},

            -- Row 4
            {167, 83, "Buy"},
            {189, 83, "Buy"},
            {211, 83, "Buy"},
            {233, 83, "Buy"},
            {255, 83, "Buy"},
            {277, 83, "Buy"},
            {299, 83, "Buy"},

            -- Row 5
            {167, 105, "Buy"},
            {189, 105, "Buy"},
            {211, 105, "Buy"},
            {233, 105, "Buy"},
            {255, 105, "Buy"},
            {277, 105, "Buy"},
            {299, 105, "Buy"},

            -- Row 6
            {167, 127, "Buy"},
            {189, 127, "Buy"},
            {211, 127, "Buy"},
            {233, 127, "Buy"},
            {255, 127, "Buy"},
            {277, 127, "Buy"},
            {299, 127, "Buy"},

            -- Row 7
            {167, 149, "Buy"},
            {189, 149, "Buy"},
            {211, 149, "Buy"},
            {233, 149, "Buy"},
            {255, 149, "Buy"},
            {277, 149, "Buy"},
            {299, 149, "Buy"},

            -- Row 8
            {167, 171, "Buy"},
            {189, 171, "Buy"},
            {211, 171, "Buy"},
            {233, 171, "Buy"},
            {255, 171, "Buy"},
            {277, 171, "Buy"},
            {299, 171, "Buy"},

            -- Row 9
            {167, 193, "Buy"},
            {189, 193, "Buy"},
            {211, 193, "Buy"},
            {233, 193, "Buy"},
            {255, 193, "Buy"},
            {277, 193, "Buy"},
            {299, 193, "Buy"},

            -- Row 10
            {167, 215, "Buy"},
            {189, 215, "Buy"},
            {211, 215, "Buy"},
            {233, 215, "Buy"},
            {255, 215, "Buy"},
            {277, 215, "Buy"},
            {299, 215, "Buy"},
        },
        info = {},
        buttons = {"Close"},
        center = true,
        invisible = true,
    }, "sprites/book.png", "sprites/catalogue_menu.png", {
        define = "catalogue_define",
        draw = "catalogue_draw"
    })

    -- Spawn the catalogue
    api_create_obj("skippers_catalogue_catalogue", -32, -32)

    return "Success"
end

-- Click hook, checks if a left mouse button has been pressed on Skipper's Boat.
-- If Skipper's Boat has been clicked, open the catalogue.
function click(button, click_type)
    if button == "LEFT" and click_type == "PRESSED" then
        highlighted = api_get_highlighted("obj")

        if highlighted ~= nil then
            inst = api_get_inst(highlighted)

            if inst["oid"] == "scenery1" then
                api_toggle_menu(catalogue_menu_id, true)
            end
        end
    end
end

function catalogue_define(menu_id)
    -- Set the global var to store the catalogue menu object ID
    catalogue_instance_id = api_gp(menu_id, "obj")

    -- Set the global var to store the catalogue menu ID
    catalogue_menu_id = menu_id

    -- Set the catalogue menu object immortal, so it doesn't unload when too far away
    api_set_immortal(catalogue_instance_id, true)
    
    -- Set "shop" property to true for all catalogue slots. This is needed for puchases to work properly.
    slots = api_get_slots(menu_id)
    for i=1, #slots do
        api_dp(slots[i]["id"], "shop", true)
    end
end

function catalogue_draw(menu_id)
    cam = api_get_cam()
    menu = api_get_inst(menu_id)

    tx = menu["x"] + 9 - cam["x"]
    ty = menu["y"] + 16 - cam["y"]

    api_draw_text(tx, ty, catalogue_text, false, "FONT_BOOK", 145)
end

-- Adds an item to the catalogue, returns "Success" if the item has been added, nil if not
function catalogue_add_item(item_oid)
    -- Find the first empty slot in the catalogue
    empty_slot = api_slot_match(catalogue_menu_id, {""}, true)

    if empty_slot ~= nil then
        -- Fill the first found empty slot with the desired item OID
        api_slot_set(empty_slot["id"], item_oid, 0)

        return "Success"
    end

    return nil
end