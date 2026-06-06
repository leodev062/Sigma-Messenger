package dto

type UpdateResponse struct {
	Status       string `json:"status"`
	VersionCode  int    `json:"version_code"`
	VersionName  string `json:"version_name"`
	URL          string `json:"url"`
	SHA256       string `json:"sha256"`
	ReleaseNotes string `json:"release_notes"`
}
