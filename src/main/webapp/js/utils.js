/*
 * 직접 만든 쓸만한 함수 모음.
 * Hawon Kim
 */

function IsJsonString(str) {
    try {
        JSON.parse(str);
        return true;
    } catch (e) {
		console.log("e: ", e.message);
        return false;
    }
}