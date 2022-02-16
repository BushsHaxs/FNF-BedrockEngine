package;

// Utils for Bedrock Engine
class BedrockUtil
{
	// hardcoded but softcoding coming soon
	public static var noteSkins:Map<String, String> = [
		'bar' => 'NOTE_bar',
		'circle' => 'NOTE_circle',
		'diamond' => 'NOTE_diamond',
		'simply' => 'NOTE_simplyarrow',
		'step' => 'NOTE_step',
		'normal' => 'NOTE_assets'
	];

	// ayo a actual helper for note shitz????
	public static function getNoteSkin(skin:String = 'normal', ?pixel:Bool = false)
	{
		var path:String = 'noteskins/';
		if (pixel)
			path = 'pixelUI/' + path;

		if (noteSkins.exists(skin.toLowerCase()))
			path += noteSkins.get(skin.toLowerCase());
		else
			path += noteSkins.get('normal');

		return path;
	}
}
