import Genius from "node-genius-api"
import YTMusic from "ytmusic-api"

export const ytmusic = new YTMusic()
ytmusic.initialize()

export const genius = new Genius(process.env.GENIUS_ACCESS_TOKEN)
