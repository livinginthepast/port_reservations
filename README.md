port_reservations
=================

Use data bags in Chef to manage specific application port reservations.

## Usage

### Data bag

Create a json file for your port reservations.

```bash
mkdir -p data_bags/ports
touch data_bags/ports/reservations.json
```

```json
{
  "id": "reservations",
  "mapping": {
    "my-app": 8000,
    "haproxy-for-my-app": 8001
  }
}
```

### Helpers

In a recipe, you can use the `PortReservation` helper to retrieve a specific port.

```ruby
include_recipe 'port_reservations'

PortReservation.for('my-app') == 8000
```

