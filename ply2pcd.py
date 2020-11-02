from argparse import ArgumentParser

import open3d as o3d


def main(args):
    pcd = o3d.io.read_point_cloud(args.ply_path)
    o3d.io.write_point_cloud(args.pcd_path, pcd)


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument(
        "--ply_path",
        type=str,
        help="path to .ply file"
    )
    parser.add_argument(
        "--pcd_path",
        type=str,
        help="path to .pcd file"
    )
    args = parser.parse_args()
    main(args)

