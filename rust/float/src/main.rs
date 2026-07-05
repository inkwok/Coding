use std::{
    io::{self, Write},
    thread,
    time::Duration,
};

const WIDTH: usize = 100;
const HEIGHT: usize = 40;

#[derive(Clone, Copy)]
struct Vec3 {
    x: f32,
    y: f32,
    z: f32,
}

fn main() {
    let vertices = [
        Vec3 { x: -1.5, y: -1.5, z: -1.5 },
        Vec3 { x:  1.5, y: -1.5, z: -1.5 },
        Vec3 { x:  1.5, y:  1.5, z: -1.5 },
        Vec3 { x: -1.5, y:  1.5, z: -1.5 },

        Vec3 { x: -1.5, y: -1.5, z:  1.5 },
        Vec3 { x:  1.5, y: -1.5, z:  1.5 },
        Vec3 { x:  1.5, y:  1.5, z:  1.5 },
        Vec3 { x: -1.5, y:  1.5, z:  1.5 },
    ];
    let faces = [
        ((0, 1, 2, 3), '@'),
        ((4, 5, 6, 7), '#'),
        ((0, 1, 5, 4), '%'),
        ((2, 3, 7, 6), '&'),
        ((1, 2, 6, 5), '*'),
        ((0, 3, 7, 4), '+'),
    ];
    let mut angle_x: f32 = 0.0;
    let mut angle_y: f32 = 0.0;
    let mut angle_z: f32 = 0.0;

    print!("\x1b[2J");

    loop {
        let mut buffer = vec![' '; WIDTH * HEIGHT];
        let mut zbuffer = vec![0.0_f32; WIDTH * HEIGHT];

        let mut projected = Vec::new();

        for &v in &vertices {
            let mut x = v.x;
            let mut y = v.y;
            let mut z = v.z;

            let y1 = y * angle_x.cos() - z * angle_x.sin();
            let z1 = y * angle_x.sin() + z * angle_x.cos();

            y = y1;
            z = z1;

            let x2 = x * angle_y.cos() + z * angle_y.sin();
            let z2 = -x * angle_y.sin() + z * angle_y.cos();

            x = x2;
            z = z2;

            let x3 = x * angle_z.cos() - y * angle_z.sin();
            let y3 = x * angle_z.sin() + y * angle_z.cos();

            x = x3;
            y = y3;

            z += 7.0;

            let perspective = 35.0 / z;

            let screen_x =
                (x * perspective + WIDTH as f32 / 2.0) as i32;

            let screen_y =
                (y * perspective + HEIGHT as f32 / 2.0) as i32;

            projected.push((screen_x, screen_y, z));
        }

        for &((a, b, c, d), ch) in &faces {
            fill_triangle(
                &mut buffer,
                &mut zbuffer,
                projected[a],
                projected[b],
                projected[c],
                ch,
            );

            fill_triangle(
                &mut buffer,
                &mut zbuffer,
                projected[a],
                projected[c],
                projected[d],
                ch,
            );
        }

        print!("\x1b[H");

        for y in 0..HEIGHT {
            for x in 0..WIDTH {
                print!("{}", buffer[y * WIDTH + x]);
            }

            println!();
        }

        io::stdout().flush().unwrap();

        angle_x += 0.03;
        angle_y += 0.02;
        angle_z += 0.015;

        thread::sleep(Duration::from_millis(16));
    }
}

fn fill_triangle(
    buffer: &mut Vec<char>,
    zbuffer: &mut Vec<f32>,
    p0: (i32, i32, f32),
    p1: (i32, i32, f32),
    p2: (i32, i32, f32),
    ch: char,
) {
    let min_x = p0.0.min(p1.0.min(p2.0)).max(0);
    let max_x = p0.0.max(p1.0.max(p2.0)).min(WIDTH as i32 - 1);

    let min_y = p0.1.min(p1.1.min(p2.1)).max(0);
    let max_y = p0.1.max(p1.1.max(p2.1)).min(HEIGHT as i32 - 1);

    let area = edge(p0, p1, p2.0, p2.1) as f32;

    if area == 0.0 {
        return;
    }

    for y in min_y..=max_y {
        for x in min_x..=max_x {
            let w0 = edge(p1, p2, x, y) as f32 / area;
            let w1 = edge(p2, p0, x, y) as f32 / area;
            let w2 = edge(p0, p1, x, y) as f32 / area;

            if w0 >= 0.0 && w1 >= 0.0 && w2 >= 0.0 {
                let z =
                    w0 * p0.2 +
                    w1 * p1.2 +
                    w2 * p2.2;

                let idx = y as usize * WIDTH + x as usize;

                if zbuffer[idx] == 0.0 || z < zbuffer[idx] {
                    zbuffer[idx] = z;
                    buffer[idx] = ch;
                }
            }
        }
    }
}

fn edge(
    a: (i32, i32, f32),
    b: (i32, i32, f32),
    x: i32,
    y: i32,
) -> i32 {
    (x - a.0) * (b.1 - a.1)
        - (y - a.1) * (b.0 - a.0)
}
