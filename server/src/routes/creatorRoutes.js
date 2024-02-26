const express = require("express");
const router = express.Router();// Adjust the path if needed

const {
  uploadVideo,
  uploadContent,
  likeContent,
  getContentDetails,
  commentContent,
  creatorCollaborator,
  rateProposal,
  updateRate,
  fetchVideos,
  fetchvideo,
  fetchVideosByCreatorId,
} = require("../controller/creatorController");


const { searchCreatorByUsername } = require("../controller/authController");

const {
  getLikesCount,
  getCommentArray,
} = require("../controller/commonController");
const { upload } = require("../common/storageInstance");
const {
  UPLOAD_CONTENT_VALIDATOR,
  COMMENT_VALIDATOR,
  isRequestValidated,
  CONTENT_COLLABRATOR_VALIDATOR,
} = require("../config/validator");
const {
  requiredSignin,
  adminMiddleware,
  userMiddleware,
} = require("../common/middleware");




router.get("/content/:content_id", requiredSignin, getContentDetails);

// Upload Details of Video Content
router.post(
  "/upload-content",
  requiredSignin,
  userMiddleware,
  UPLOAD_CONTENT_VALIDATOR,
  isRequestValidated,
  uploadContent
);

//Upload Video of Video Content
router.post(
  "/upload-video/:content_id",
  requiredSignin,
  userMiddleware,
  upload.single("video_file"),
  uploadVideo
);
// router.post(
//   "/upload-video/:content_id",
//   requiredSignin,
//   userMiddleware,
//   upload.single("video_file"),
//   async (req, res) => {
//     // Validate req.params.content_id and req.file
//     const contentId = req.params.content_id;
//     const videoPath = req.file.path;

//   }
// );
// router.post('/api/v1/upload-video/:content_id', upload.single('video_file'), uploadVideo);


// colaboration
router.post(
  "/collaborators",
  // requiredSignin,
  // userMiddleware,
  searchCreatorByUsername
)

// add colaborator
router.post(
  "/collab/:content_id",
  requiredSignin,
  userMiddleware,
  creatorCollaborator
)

// fetch video
router.get("/video/:videoId", requiredSignin, fetchvideo);
router.get('/videos', requiredSignin, fetchVideos);
router.get('/videos/:creatorId', requiredSignin, fetchVideosByCreatorId);


// Like, Comment, Collaborate and Rate Proposal


router.post("/like/:content_id", requiredSignin, userMiddleware, likeContent);
router.post(
  "/comment/:content_id",
  requiredSignin,
  userMiddleware,
  COMMENT_VALIDATOR,
  isRequestValidated,
  commentContent
);
router.post(
  "/content-collabration/:content_id",
  requiredSignin,
  userMiddleware,
  CONTENT_COLLABRATOR_VALIDATOR,
  isRequestValidated,
  creatorCollaborator
);
router.get(
  "/likes-count/:content_id",
  requiredSignin,
  userMiddleware,
  getLikesCount
);
router.get(
  "/content-comments/:content_id",
  requiredSignin,
  userMiddleware,
  getCommentArray
);
router.post("/rate-proposal", requiredSignin, userMiddleware, rateProposal);
router.post(
  "/rate-proposal-approval",
  requiredSignin,
  adminMiddleware,
  updateRate
);

module.exports = router;
