export default function Flexbox() {
  const containers = document.getElementsByName('list');
  console.log(containers);

  if (containers.length === 0) {
    return false;
  }

  const swappable = new Swappable(containers, {
    draggable: '.Block--isDraggable',
    mirror: {
      constrainDimensions: true,
    },
    plugins: [Plugins.ResizeMirror],
  });

  return swappable;
}
