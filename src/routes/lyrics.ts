import axios from "axios"
import googleIt from "google-it"
import { useTry } from "no-try"
import { OBJECT, STRING } from "validate-any"

import { Route } from "../setup"

export class GET extends Route<any, { query: string }> {
	override queryValidator = OBJECT({
		query: STRING()
	})

	async handle() {
		const results = await googleIt({
			query: `${this.query.query} site:genius.com`,
			"no-display": true
		})

		const result = results
			.filter(result => result.link.match(/^https:\/\/genius\.com\/[\w-]+$/))
			.filter(result => !result.title.match(/\(Romanized|\w+ Translation\) Lyrics - Genius$/))
			.at(0)

		if (!result) {
			this.throw("Failed to find results on Google for search query")
			return
		}

		const html = (await axios.get<string>(result.link)).data
		const lyrics = html
			.match(/JSON\.parse\('(.*)'\)/)!
			.map(j => j.slice(12, -2))
			.map(j => j.replaceAll("\\\\", "\\"))
			.map(j => j.replaceAll('\\"', '"'))
			.map(j => j.replaceAll("\\'", "'"))
			.map(j => useTry(() => JSON.parse(j))[1])
			.filter(j => !!j)
			.at(0)?.songPage?.lyricsData?.body

		if (lyrics === undefined) {
			this.throw("Failed to fetch lyrics from genius.com")
			return
		}

		const getLyrics = (lyrics: any): string => {
			if (typeof lyrics === "string") {
				return lyrics
			}

			if ("children" in lyrics) {
				return lyrics.children.map(getLyrics).join("")
			}

			if ("tag" in lyrics && lyrics.tag === "br") {
				return "\n"
			}

			return ""
		}

		this.respond(
			getLyrics(lyrics)
				.replaceAll(/(\[.*\])/g, "")
				.replaceAll(/\n+/g, "\n")
				.trim()
				.split("\n")
		)
		return
	}
}
