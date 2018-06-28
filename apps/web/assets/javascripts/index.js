import React from 'react';
import ReactDOM from 'react-dom';

const user_id = document.getElementById('user_id').innerHTML;
const csrf = document.getElementsByName('csrf')[0].content;
const formData = new FormData();
formData.append("_csrf_token", csrf);


class ListContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      error: null,
      isLoaded: false,
      lists: []
    };
  }

  componentDidMount() {
    fetch("/api/lists/index/" + user_id)
      .then(res => res.json())
      .then(
        (result) => {
          this.setState({
            isLoaded: true,
            lists: result
          });
        },
        (error) => {
          this.setState({
            isLoaded: true,
            error
          });
        }
      )
  }

  render() {
    const { error, isLoaded, lists } = this.state;
    if (error) {
      return <div>Error: {error.message}</div>;
    } else if (!isLoaded) {
      return <div>Loading...</div>;
    } else {
      return (
				<div className="flex flex-wrap my-3 mx-4">
					{lists.map(list => (
						<List id={list.id} name={list.name} done={list.done} />
					))}
				</div>
      );
    }
  }
}

ReactDOM.render(
	<ListContainer />,
	document.getElementById('root')
);

class List extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			error: null,
			isLoaded: false,
			name: this.props.name,
			items: [],
			done: this.props.done
		};
	}

	componentDidMount() {
		fetch('/api/items/index/' + this.props.id)
			.then(res => res.json())
			.then(
				(result) => {
					this.setState({
						isLoaded: true,
						items: result
					});
				},
				(error) => {
					this.setState({
						isLoaded: true,
						error
					});
				}
			)
	}

	render() {
		const { error, isLoaded, name, items, done } = this.state;
		if (error) {
			return <div>ERROR: loading List component</div>;
		} else if (!isLoaded) {
			return <div>Loading...</div>;
		} else {
			return (
				<div className="list self-start bg-white overflow-hidden py-4 mx-2 my-2">
					<div className="px-6 text-2xl font-bold text-grey-dark">
						{name}
					</div>
					<div className="px-6">
						<ul>
							{items.map(item => (
								<Item id={item.id} text={item.text} />
							))}
						</ul>
					</div>
				</div>
      );
		}
	}
}

class Item extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      error: null,
      isLoaded: false,
      subitems: []
    };
  }

  componentDidMount() {
    fetch("/api/subitems/index/" + this.props.id)
      .then(res => res.json())
      .then(
        (result) => {
          this.setState({
            isLoaded: true,
            subitems: result
          });
        },
        (error) => {
          this.setState({
            isLoaded: true,
            error
          });
        }
      )
  }

  render() {
    const { error, isLoaded, subitems } = this.state;
    if (error) {
      return <div>Error: {error.message}</div>;
    } else if (!isLoaded) {
      return <div>Loading...</div>;
    } else {
      return (
				<div className="container">
					<div className="item-text">
						{this.props.text}
					</div>
					<div className="item-subitems px-3">
						<ul>
							{subitems.map(subitem=> (
								<Subitem id={subitem.id} text={subitem.text} done={subitem.done} />
							))}
						</ul>
					</div>
				</div>
      );
    }
  }
}

class Subitem extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      done: this.props.done
    };
  }

  render() {
    const done = this.state.done;
		return (
			<div className="container">
				<div className="subitem-text">
					{this.props.text}
				</div>
			</div>
    );
  }
}

