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

= Quaternions

== The Quaternion Algebra

The _quaternions_ $HH$ extend $CC$ by adding two more imaginary units $j$ and $k$:

$ q = a + b i + c j + d k, quad a, b, c, d in RR $

The multiplication rules are:
$ i^2 = j^2 = k^2 = -1, quad i j = k, quad j k = i, quad k i = j $

Multiplication is _not commutative_: $j i = -k$, etc.

== A 4D Space

A quaternion $q = a + b i + c j + d k$ lives in $RR^4$ with basis ${1, i, j, k}$.

The _pure imaginary_ quaternions $b i + c j + d k$ form a copy of $RR^3$.

The _conjugate_ is $overline(q) = a - b i - c j - d k$, and
$ |q|^2 = q overline(q) = a^2 + b^2 + c^2 + d^2 $

== Left-Multiplication by $i$

What does $q |-> i q$ do to the four basis elements?

$ 1 arrow.r.bar i, quad i arrow.r.bar -1, quad j arrow.r.bar k, quad k arrow.r.bar -j $

#align(center, cetz.canvas(length: 1.2cm, {
  import cetz.draw: *

  // (1, i) plane
  let cx1 = -2.5
  let r = 1.2

  set-style(stroke: gray + 0.5pt)
  line((cx1 - 1.7, 0), (cx1 + 1.7, 0), mark: (end: ">", fill: black))
  line((cx1, -1.7), (cx1, 1.7), mark: (end: ">", fill: black))

  let pts1 = (
    ($1$, 0deg, (cx1 + r + 0.3, -0.3)),
    ($i$, 90deg, (cx1 + 0.3, r + 0.3)),
    ($-1$, 180deg, (cx1 - r - 0.4, -0.3)),
    ($-i$, 270deg, (cx1 + 0.3, -r - 0.3)),
  )

  for k in range(4) {
    let (_, start-angle, _) = pts1.at(k)
    let (_, end-angle, _) = pts1.at(calc.rem(k + 1, 4))
    let start-pt = (cx1 + calc.cos(start-angle) * r, calc.sin(start-angle) * r)
    let end-pt = (cx1 + calc.cos(end-angle) * r, calc.sin(end-angle) * r)
    let mid-angle = start-angle + 45deg
    let bend-pt = (cx1 + calc.cos(mid-angle) * (r + 0.4), calc.sin(mid-angle) * (r + 0.4))
    set-style(stroke: blue + 1.5pt)
    bezier(start-pt, end-pt, bend-pt, mark: (end: ">", fill: blue))
  }

  for (label, angle, pos) in pts1 {
    set-style(stroke: none)
    circle((cx1 + calc.cos(angle) * r, calc.sin(angle) * r), radius: 0.06, fill: black)
    content(pos, label)
  }

  content((cx1, -2.3), text(fill: blue)[$(1, i)$ plane: CCW $90°$])

  // (j, k) plane
  let cx2 = 2.5

  set-style(stroke: gray + 0.5pt)
  line((cx2 - 1.7, 0), (cx2 + 1.7, 0), mark: (end: ">", fill: black))
  line((cx2, -1.7), (cx2, 1.7), mark: (end: ">", fill: black))

  let pts2 = (
    ($j$, 0deg, (cx2 + r + 0.3, -0.3)),
    ($k$, 90deg, (cx2 + 0.3, r + 0.3)),
    ($-j$, 180deg, (cx2 - r - 0.4, -0.3)),
    ($-k$, 270deg, (cx2 + 0.3, -r - 0.3)),
  )

  for k in range(4) {
    let (_, start-angle, _) = pts2.at(k)
    let (_, end-angle, _) = pts2.at(calc.rem(k + 1, 4))
    let start-pt = (cx2 + calc.cos(start-angle) * r, calc.sin(start-angle) * r)
    let end-pt = (cx2 + calc.cos(end-angle) * r, calc.sin(end-angle) * r)
    let mid-angle = start-angle + 45deg
    let bend-pt = (cx2 + calc.cos(mid-angle) * (r + 0.4), calc.sin(mid-angle) * (r + 0.4))
    set-style(stroke: red + 1.5pt)
    bezier(start-pt, end-pt, bend-pt, mark: (end: ">", fill: red))
  }

  for (label, angle, pos) in pts2 {
    set-style(stroke: none)
    circle((cx2 + calc.cos(angle) * r, calc.sin(angle) * r), radius: 0.06, fill: black)
    content(pos, label)
  }

  content((cx2, -2.3), text(fill: red)[$(j, k)$ plane: CCW $90°$])
}))

Left-multiplication by $i$ rotates both planes by $90°$ counterclockwise.

== Right-Multiplication by $i$

Now consider $q |-> q i$:

$ 1 arrow.r.bar i, quad i arrow.r.bar -1, quad j arrow.r.bar -k, quad k arrow.r.bar j $

#align(center, cetz.canvas(length: 1.2cm, {
  import cetz.draw: *

  let cx1 = -2.5
  let r = 1.2

  // (1, i) plane — same as before
  set-style(stroke: gray + 0.5pt)
  line((cx1 - 1.7, 0), (cx1 + 1.7, 0), mark: (end: ">", fill: black))
  line((cx1, -1.7), (cx1, 1.7), mark: (end: ">", fill: black))

  let pts1 = (
    ($1$, 0deg, (cx1 + r + 0.3, -0.3)),
    ($i$, 90deg, (cx1 + 0.3, r + 0.3)),
    ($-1$, 180deg, (cx1 - r - 0.4, -0.3)),
    ($-i$, 270deg, (cx1 + 0.3, -r - 0.3)),
  )

  for k in range(4) {
    let (_, start-angle, _) = pts1.at(k)
    let (_, end-angle, _) = pts1.at(calc.rem(k + 1, 4))
    let start-pt = (cx1 + calc.cos(start-angle) * r, calc.sin(start-angle) * r)
    let end-pt = (cx1 + calc.cos(end-angle) * r, calc.sin(end-angle) * r)
    let mid-angle = start-angle + 45deg
    let bend-pt = (cx1 + calc.cos(mid-angle) * (r + 0.4), calc.sin(mid-angle) * (r + 0.4))
    set-style(stroke: blue + 1.5pt)
    bezier(start-pt, end-pt, bend-pt, mark: (end: ">", fill: blue))
  }

  for (label, angle, pos) in pts1 {
    set-style(stroke: none)
    circle((cx1 + calc.cos(angle) * r, calc.sin(angle) * r), radius: 0.06, fill: black)
    content(pos, label)
  }

  content((cx1, -2.3), text(fill: blue)[$(1, i)$ plane: CCW $90°$])

  // (j, k) plane — REVERSED
  let cx2 = 2.5

  set-style(stroke: gray + 0.5pt)
  line((cx2 - 1.7, 0), (cx2 + 1.7, 0), mark: (end: ">", fill: black))
  line((cx2, -1.7), (cx2, 1.7), mark: (end: ">", fill: black))

  let pts2 = (
    ($j$, 0deg, (cx2 + r + 0.3, -0.3)),
    ($k$, 90deg, (cx2 + 0.3, r + 0.3)),
    ($-j$, 180deg, (cx2 - r - 0.4, -0.3)),
    ($-k$, 270deg, (cx2 + 0.3, -r - 0.3)),
  )

  // CW cycle: j → -k → -j → k → j
  let cw-order = (0, 3, 2, 1)
  for idx in range(4) {
    let from = cw-order.at(idx)
    let to = cw-order.at(calc.rem(idx + 1, 4))
    let (_, start-angle, _) = pts2.at(from)
    let (_, end-angle, _) = pts2.at(to)
    let start-pt = (cx2 + calc.cos(start-angle) * r, calc.sin(start-angle) * r)
    let end-pt = (cx2 + calc.cos(end-angle) * r, calc.sin(end-angle) * r)
    let mid-angle = start-angle - 45deg
    let bend-pt = (cx2 + calc.cos(mid-angle) * (r + 0.4), calc.sin(mid-angle) * (r + 0.4))
    set-style(stroke: red + 1.5pt)
    bezier(start-pt, end-pt, bend-pt, mark: (end: ">", fill: red))
  }

  for (label, angle, pos) in pts2 {
    set-style(stroke: none)
    circle((cx2 + calc.cos(angle) * r, calc.sin(angle) * r), radius: 0.06, fill: black)
    content(pos, label)
  }

  content((cx2, -2.3), text(fill: red)[$(j, k)$ plane: CW $90°$])
}))

The $(1, i)$ plane behaves the same, but the $(j, k)$ cycle is *reversed*.

== The Sandwich Product $i q (-i)$

Compose left-multiplication by $i$ with right-multiplication by $-i$:

#align(center, table(
  columns: 3,
  stroke: none,
  align: center,
  table.header[*Plane*][*Left by $i$*][*Right by $-i$*],
  table.hline(),
  [$(1, i)$], [CCW $90°$], [CW $90°$],
  [$(j, k)$], [CCW $90°$], [CCW $90°$],
))

- $(1, i)$ plane: $90° - 90° = 0°$ — *fixed!*
- $(j, k)$ plane: $90° + 90° = 180°$ — *rotated by $180°$*

So $q |-> i q (-i)$ rotates the $(j, k)$ plane (perpendicular to $i$) by $180°$ while leaving the $(1, i)$ plane unchanged.

== Generalizing to Any Unit Imaginary Quaternion

Nothing was special about $i$. For any unit imaginary quaternion $bold(u)$ (with $bold(u)^2 = -1$), we can decompose $HH = RR^4$ into:

- The $(1, bold(u))$ plane
- The plane perpendicular to $bold(u)$ in $"Im"(HH)$

Then $q |-> bold(u) q (-bold(u))$ rotates the perpendicular plane by $180°$ while fixing the $(1, bold(u))$ plane.

== From $90°$ to Arbitrary Angles

Recall from Euler's formula: $exp(i t)$ is a $t$-radian rotation in the complex plane.

The same applies in $HH$: for a unit imaginary quaternion $bold(u)$,

$ exp(bold(u) t) = cos t + bold(u) sin t $

Left-multiplying by $exp(bold(u) t)$ rotates both planes by $t$ radians (CCW). Right-multiplying by $exp(bold(u) t)$ rotates the $(1, bold(u))$ plane by $t$ (CCW) but the perpendicular plane by $t$ (*CW*).

== The Sandwich Product $exp(bold(u) t) thin q thin exp(-bold(u) t)$

Composing both:

#align(center, table(
  columns: 3,
  stroke: none,
  align: center,
  table.header[*Plane*][*Left by $exp(bold(u) t)$*][*Right by $exp(-bold(u) t)$*],
  table.hline(),
  [$(1, bold(u))$], [CCW $t$], [CW $t$],
  [$perp bold(u)$], [CCW $t$], [CCW $t$],
))

- $(1, bold(u))$ plane: $t - t = 0$ — *fixed*
- $perp bold(u)$ plane: $t + t = 2t$ — *rotated by $2t$*

For a pure imaginary quaternion $bold(v) in "Im"(HH) tilde.equiv RR^3$, the $(1, bold(u))$ component is zero anyway, so this is a rotation of $RR^3$ by angle $2t$ around axis $bold(u)$.

== The Quaternion Rotation Formula

Setting $theta = 2t$ and writing $q = exp(bold(u) thin theta\/2) = cos(theta\/2) + bold(u) sin(theta\/2)$:

#align(center, box(stroke: blue + 1pt, inset: 12pt, radius: 4pt)[
  To rotate $bold(v) in RR^3$ by angle $theta$ around unit axis $bold(u)$:
  $ bold(v) |-> q thin bold(v) thin overline(q), quad q = cos theta/2 + bold(u) sin theta/2 $
])

The half-angle appears because each side of the sandwich contributes half the rotation.

== Quaternions $<==>$ Angle-Axis Representation

Just as with rotation matrices:

$ q = exp(bold(u) thin theta\/2), quad overline(q) = exp(-bold(u) thin theta\/2) $

And the same periodicity: a full $2 pi$ rotation around $bold(u)$ sends $theta\/2 |-> theta\/2 + pi$, which _negates_ $q$:

$ q "and" -q "represent the same rotation" $

The map from unit quaternions to rotations is surjective onto $"SO"(3)$, but $2$-to-$1$: every rotation has exactly two quaternion representatives, $plus.minus q$.
