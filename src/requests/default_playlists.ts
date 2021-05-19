import admin from "firebase-admin"
import { Playlist, Song } from "../all"

export default async (
	TAG: string,
	firestore: admin.firestore.Firestore,
	userId: string
) => {
	console.log(TAG, "Defaulting for userId: " + userId)

	const COMTPlaylistId = firestore.collection("playlists").doc().id
	const COMTPlaylist: Playlist = {
		id: COMTPlaylistId,
		name: "COMT Default",
		order: ["OkuYtCNGIY0", "Kr4EQDVETuA", "SlbfAYvA_gI"],
		colorHex: "#7b828b",
		cover: "https://firebasestorage.googleapis.com/v0/b/android-soundroid.appspot.com/o/playing_cover_default.png?alt=media&token=e8980e80-ab5d-4f21-8ed4-6bc6e7e06ef7",
		userId
	}
	const COMTSongs: Song[] = [
		{
			songId: "OkuYtCNGIY0",
			title: "The Way You Look Tonight",
			artiste: "Frank Sinatra",
			cover: "https://i.ytimg.com/vi/OkuYtCNGIY0/maxresdefault.jpg",
			colorHex: "#2E5874",
			playlistId: COMTPlaylistId,
			userId
		},
		{
			songId: "Kr4EQDVETuA",
			title: "Billie Jean",
			artiste: "Michael Jackson",
			cover: "https://i.ytimg.com/vi/Kr4EQDVETuA/maxresdefault.jpg",
			colorHex: "#535C5B",
			playlistId: COMTPlaylistId,
			userId
		},
		{
			songId: "SlbfAYvA_gI",
			title: "Photograph",
			artiste: "Ed Sheeran",
			cover: "https://i.ytimg.com/vi/SlbfAYvA_gI/maxresdefault.jpg",
			colorHex: "#008621",
			playlistId: COMTPlaylistId,
			userId
		}
	]

	const IUPlaylistId = firestore.collection("playlists").doc().id
	const IUPlaylist: Playlist = {
		id: IUPlaylistId,
		name: "IU Best Songs",
		order: [
			"v7bnOxV4jAc",
			"0-q1KafFCLU",
			"TqIAndOnd74",
			"JSOBF_WhqEM",
			"I0_ZXHzKysc"
		],
		cover: "https://akns-images.eonline.com/eol_images/Entire_Site/20181026/rs_600x600-181126230834-e-asia-iu-things-to-know-thumbnail.jpg?fit=around%7C1200:1200&output-quality=90&crop=1200:1200;center,top",
		colorHex: "#A88867",
		userId
	}
	const IUSongs: Song[] = [
		{
			songId: "v7bnOxV4jAc",
			title: "Lilac",
			artiste: "IU",
			cover: "https://bandwagon-gig-finder.s3.amazonaws.com/system/tinymce/image/file/2156/content_mceu_47980652711616659911799.jpg",
			colorHex: "#977A82",
			playlistId: IUPlaylistId,
			userId
		},
		{
			songId: "0-q1KafFCLU",
			title: "Celebrity",
			artiste: "IU",
			cover: "https://images.genius.com/6982887c1eaa2cf8e4944902683605ac.1000x1000x1.jpg",
			colorHex: "#F0A780",
			playlistId: IUPlaylistId,
			userId
		},
		{
			songId: "I0_ZXHzKysc",
			title: "Blueming",
			artiste: "IU",
			cover: "https://static.wikia.nocookie.net/kpop/images/7/74/IU_Love_Poem_digital_album_cover.png/revision/latest?cb=20191118091429",
			colorHex: "#B6A6B4",
			playlistId: IUPlaylistId,
			userId
		},
		{
			songId: "TqIAndOnd74",
			title: "My Sea",
			artiste: "IU",
			cover: "https://bandwagon-gig-finder.s3.amazonaws.com/system/tinymce/image/file/2156/content_mceu_47980652711616659911799.jpg",
			colorHex: "#977A82",
			playlistId: IUPlaylistId,
			userId
		},
		{
			songId: "JSOBF_WhqEM",
			title: "Dear Name",
			artiste: "IU",
			cover: "https://static.wikia.nocookie.net/iandyou/images/5/5a/Palette_Digital_Cover.jpg/revision/latest?cb=20200806164754",
			colorHex: "#CDB6B3",
			playlistId: IUPlaylistId,
			userId
		}
	]

	await firestore
		.collection("playlists")
		.doc(COMTPlaylistId)
		.set(COMTPlaylist)

	for (let i = 0, il = COMTSongs.length; i < il; i++) {
		const COMTSong = COMTSongs[i]
		await firestore
			.collection("songs")
			.add(COMTSong)
	}

	await firestore
		.collection("playlists")
		.doc(IUPlaylistId)
		.set(IUPlaylist)

	for (let i = 0, il = IUSongs.length; i < il; i++) {
		const IUSong = IUSongs[i]
		await firestore.collection("songs").add(IUSong)
	}
}