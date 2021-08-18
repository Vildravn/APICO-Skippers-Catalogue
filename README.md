# Skipper's Catalogue

A mod for [APICO](https://apico.buzz/) that adds a catalogue to order items from  
Other mods can use this to get their custom items (e.g. custom workbenches) into an existing world without much hassle

## Usage
User:
* Click Skipper's Boat to access the catalogue

Modder:
1. Make sure your item has a shop_buy value defined. It can be 0 if you'd like, this is the cost of the item in the catalogue
2. Check whether the mod exists with `api_mod_exists("skippers_catalogue")`
3. Add an item to the catalogue by calling `api_mod_call("skippers_catalogue", "catalogue_add_item", "[item_oid]")`
   The method will return "Success" if the item has been added and "nil" if it failed (most commonly due to the catalogue being full)  
   To add a log into the catalog, you'd call `api_mod_call("skippers_catalogue", "catalogue_add_item", "log")`