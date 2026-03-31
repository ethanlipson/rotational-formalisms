#import "@preview/diatypst:0.8.0": *
#import "@preview/cetz:0.3.4"

#show: slides.with(
  title: "Rotational Formalisms",
  date: "3/30/26",
  authors: "Ethan Lipson",

  // Optional Styling (for more and explanation of options take a look at the typst universe)
  ratio: 16 / 9,
  layout: "medium",
  title-color: blue.darken(60%),
  toc: false,
)

= Complex Numbers

== Euler's Formula

The celebrated _Euler's formula_

$ exp(i t) = cos t + i sin t $

Why might we expect this to be true?

== Exp and Relative Velocity

The defining property of $exp(k t)$ is

$ underbrace(dif / (dif t) exp(k t), "velocity") = k dot underbrace(exp(k t), "position") $

The constant $k$ is the relative velocity: the ratio of velocity to position.

== Example: Real $k$

Let $f(t) = exp(2t)$. Then $f'(t) = 2 f(t)$: the velocity is always $2 times$ the current value.

#align(center, cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // Axis
  set-style(stroke: gray + 0.5pt)
  line((-0.5, 0), (10, 0), mark: (end: ">", fill: black))

  // Tick marks
  for x in range(1, 10) {
    line((x, -0.1), (x, 0.1))
  }

  // Point at t=0: exp(0) = 1
  set-style(stroke: none)
  circle((1, 0), radius: 0.12, fill: blue)
  content((1, 0.6), text(fill: blue)[$t = 0$])

  // Velocity arrow at t=0
  set-style(stroke: blue + 1.5pt)
  line((1, -0.4), (1.7, -0.4), mark: (end: ">", fill: blue))
  content((1.5, -0.9), text(size: 0.7em, fill: blue)[vel $= 2 e^0 = 2$])

  // Point at t=0.5: exp(1) ≈ 2.7
  set-style(stroke: none)
  circle((2.7, 0), radius: 0.12, fill: red)
  content((2.7, 0.6), text(fill: red)[$t = 1\/2$])

  // Velocity arrow at t=0.5
  set-style(stroke: red + 1.5pt)
  line((2.7, -0.4), (4.5, -0.4), mark: (end: ">", fill: red))
  content((3.6, -0.9), text(size: 0.7em, fill: red)[vel $= 2 e^1$])

  // Point at t=1: exp(2) ≈ 7.4
  set-style(stroke: none)
  circle((7.4, 0), radius: 0.12, fill: purple)
  content((7.4, 0.6), text(fill: purple)[$t = 1$])

  // Velocity arrow at t=1
  set-style(stroke: purple + 1.5pt)
  line((7.4, -0.4), (11, -0.4), mark: (end: ">", fill: purple))
  content((8.3, -0.9), text(size: 0.7em, fill: purple)[vel $= 2 e^2$])
}))

As position grows, velocity grows proportionally

== Now What if $k = i$?

Now consider $f(t) = exp(i t)$. The rule $f'(t) = i dot f(t)$ says:

#align(center, box(stroke: blue + 1pt, inset: 12pt, radius: 4pt)[
  The velocity is always $i times$ the current position.
])

What does multiplying by $i$ do geometrically? It rotates by $90°$ counterclockwise!

#align(center, cetz.canvas(length: 1.2cm, {
  import cetz.draw: *

  let r = 1.5

  // Axes
  set-style(stroke: gray + 0.5pt)
  line((-2, 0), (2, 0), mark: (end: ">", fill: black))
  line((0, -2), (0, 2), mark: (end: ">", fill: black))


  let pts = (
    ($1$, 0deg, (r + 0.3, -0.2)),
    ($i$, 90deg, (0.2, r + 0.3)),
    ($-1$, 180deg, (-r - 0.4, -0.2)),
    ($-i$, 270deg, (0.2, -r - 0.3)),
  )

  // Four arcs from z to z*i along the unit circle
  let colors = (blue, red, purple, olive)
  for k in range(4) {
    let (_, start-angle, _) = pts.at(k)
    let (_, end-angle, _) = pts.at(calc.rem(k + 1, 4))
    let start-pt = (calc.cos(start-angle) * r, calc.sin(start-angle) * r)
    let end-pt = (calc.cos(end-angle) * r, calc.sin(end-angle) * r)
    let mid-angle = start-angle + 45deg
    let bend-pt = (calc.cos(mid-angle) * (r + 0.4), calc.sin(mid-angle) * (r + 0.4))
    set-style(stroke: colors.at(k) + 1.5pt)
    bezier(start-pt, end-pt, bend-pt, mark: (end: ">", fill: colors.at(k)))
  }

  // Labels and dots at each point
  for (label, angle, pos) in pts {
    set-style(stroke: none)
    circle((calc.cos(angle) * r, calc.sin(angle) * r), radius: 0.06, fill: black)
    content(pos, label)
  }
}))

== Circular Motion in $CC$

#align(center, cetz.canvas(length: 1.5cm, {
  import cetz.draw: *

  let r = 1.8

  // Axes
  set-style(stroke: gray + 0.5pt)
  line((-2.3, 0), (2.3, 0), mark: (end: ">", fill: black))
  line((0, -2.3), (0, 2.3), mark: (end: ">", fill: black))

  // Unit circle
  set-style(stroke: gray.darken(20%) + 1pt)
  circle((0, 0), radius: r)

  // t = 0: point at (1, 0)
  let p0 = (r, 0)
  set-style(stroke: none)
  circle(p0, radius: 0.07, fill: blue)

  // Velocity at t=0: pointing up (i * 1 = i)
  set-style(stroke: blue + 2pt)
  line(p0, (r, 0.7), mark: (end: ">", fill: blue))
  content((r + 0.5, 0.4), text(size: 0.8em, fill: blue)[vel $= i$])

  // t = π/4: point at (cos 45°, sin 45°)
  let a = calc.cos(45deg) * r
  let p1 = (a, a)
  set-style(stroke: none)
  circle(p1, radius: 0.07, fill: red)

  // Velocity at t=π/4: i * (cos45 + i sin45) = -sin45 + i cos45, i.e. perpendicular
  set-style(stroke: red + 2pt)
  line(p1, (a - 0.5, a + 0.5), mark: (end: ">", fill: red))

  // t = π/2: point at (0, 1)
  let p2 = (0, r)
  set-style(stroke: none)
  circle(p2, radius: 0.07, fill: purple)

  // Velocity at t=π/2: i * i = -1, pointing left
  set-style(stroke: purple + 2pt)
  line(p2, (-0.7, r), mark: (end: ">", fill: purple))
  content((-0.5, r + 0.3), text(size: 0.8em, fill: purple)[vel $= -1$])
}))

So the velocity is always perpendicular to the position, and this is exactly what produces circular motion!

== Periodicity of $exp(i theta)$

Since $exp(i t)$ traces the unit circle, after a full revolution ($t = 2 pi$) we return to the start:

$ exp(2 pi i) = 1 $

So $exp(i theta)$ is periodic with period $2 pi i$:

$ exp(i theta) = exp(i (theta + 2 pi n)) quad "for any" n in ZZ $

The map $theta |-> exp(i theta)$ is surjective onto the unit circle, but not injective: every point has infinitely many preimages.

= Rotation Matrices

== The Same Idea in 3D

In the complex plane, multiplying by $i$ rotated a vector by $90°$.

In $RR^3$, what operation takes a vector and produces something perpendicular to it?

The cross product! Given a fixed axis $bold(omega)$, the map $bold(v) |-> bold(omega) times bold(v)$ is always $perp$ to $bold(v)$.

== The Cross Product as a Matrix

The cross product $bold(omega) times bold(v)$ is linear in $bold(v)$, so it can be written as a matrix multiplication:

$ bold(omega) times bold(v) = [bold(omega)]_times bold(v) $

where $[bold(omega)]_times$ is the skew-symmetric matrix

$ [bold(omega)]_times = mat(0, -omega_3, omega_2; omega_3, 0, -omega_1; -omega_2, omega_1, 0) $

== Analogy with Euler's Formula

Recall: in the complex plane, $exp(i t)$ traces a circle because $i$ rotates by $90°$.

/ *Matrix Exponential*: $exp(A) = I + A + A^2/2! + dots.c$ satisfies $dif / (dif t) exp(t A) = A exp(t A)$.

So if we set $f(t) = exp(t [bold(omega)]_times) bold(v)$, then

$ dif / (dif t) f(t) = [bold(omega)]_times f(t) $

The velocity is always $bold(omega) times "position"$, always perpendicular. This is circular motion around the axis $bold(omega)$!

== Exp of a Skew-Symmetric Matrix is a Rotation

#align(center, cetz.canvas(length: 1.4cm, {
  import cetz.draw: *

  // Axis arrow (ω)
  set-style(stroke: gray + 1.5pt)
  line((0, -1.5), (0, 2.2), mark: (end: ">", fill: gray))
  content((0.4, 2.2), $bold(omega)$)

  // Circle in perspective (ellipse)
  set-style(stroke: gray.darken(20%) + 1pt)
  let rx = 1.5
  let ry = 0.5
  circle((0, 0), radius: (rx, ry))

  // Vector v
  set-style(stroke: blue + 2pt)
  line((0, 0), (1.5, 0), mark: (end: ">", fill: blue))
  content((1.5, -0.3), text(fill: blue)[$bold(v)$])

  // Rotated vector
  set-style(stroke: red + 2pt)
  line((0, 0), (-0.9, 0.45), mark: (end: ">", fill: red))
  content((-1.2, 0.6), text(fill: red)[$R bold(v)$])

  // Velocity arrow (perpendicular)
  set-style(stroke: purple + 1.5pt)
  line((1.5, 0), (1.4, 0.7), mark: (end: ">", fill: purple))
  content((1.9, 0.6), text(size: 0.8em, fill: purple)[$bold(omega) times bold(v)$])

  // Curved arrow showing rotation
  set-style(stroke: black + 1pt)
  bezier((1.3, 0.3), (-0.5, 0.55), (0.5, 1.0), mark: (end: ">", fill: black))
}))

$ exp(t [bold(omega)]_times) = R(bold(omega), t) $

== Rotation Matrices $<==>$ Angle-Axis Representation

Every rotation vector $bold(omega) in RR^3$ gives a rotation matrix via $exp([bold(omega)]_times)$, and every rotation matrix arises this way.

But same periodicity as $exp(i theta)$: a full $2 pi$ rotation around the axis changes nothing.

$ exp([bold(omega)]_times) = exp([(bold(omega) + 2 pi hat(bold(omega))) ]_times) $

$exp$ is surjective onto $"SO"(3)$, but each rotation matrix has infinitely many preimages, differing by $2 pi$ multiples along the axis.
