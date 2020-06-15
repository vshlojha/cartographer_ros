
-- include "amr_2d_with_odometry.lua"
include "amr_2d.lua"
TRAJECTORY_BUILDER.pure_localization_trimmer = {
  max_submaps_to_keep = 3,
}
-- output map to base_link for evaluation
options.provide_odom_frame = false
options.use_odometry = true
options.published_frame = "odom"

-- no need to evaluate live
POSE_GRAPH.optimization_problem.log_solver_summary = false
POSE_GRAPH.constraint_builder.log_matches = false

TRAJECTORY_BUILDER_2D.submaps.num_range_data=0.5*TRAJECTORY_BUILDER_2D.submaps.num_range_data
--TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.linear_search_window = 0.15
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.angular_search_window = math.rad(2.5)
TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching=true


-- fast localization
MAP_BUILDER.num_background_threads = 4
POSE_GRAPH.constraint_builder.sampling_ratio = 0.5 * POSE_GRAPH.constraint_builder.sampling_ratio
POSE_GRAPH.global_sampling_ratio = 0.1 * POSE_GRAPH.global_sampling_ratio
POSE_GRAPH.max_num_final_iterations = 4
POSE_GRAPH.optimize_every_n_nodes = 1
POSE_GRAPH.constraint_builder.min_score = 0.55
POSE_GRAPH.global_constraint_search_after_n_seconds = 100
--TRAJECTORY_BUILDER_2D.ceres_scan_matcher.translation_weight = 10. 
--TRAJECTORY_BUILDER_2D.ceres_scan_matcher.rotation_weight = 0.01

-- Mixing odometry in localization
POSE_GRAPH.optimization_problem.local_slam_pose_translation_weight = 1.
POSE_GRAPH.optimization_problem.local_slam_pose_rotation_weight =1. 
POSE_GRAPH.optimization_problem.odometry_translation_weight = 0.0
POSE_GRAPH.optimization_problem.odometry_rotation_weight = 0.0

return options
