import clsx from 'clsx';
import Heading from '@theme/Heading';
import styles from './styles.module.css';
import Hotbar_EasyToUse from '@site/static/gif/Hotbar_EasyToUse.gif';
import Hotbar_ObjectOriented from '@site/static/gif/Hotbar_ObjectOriented.gif';
import Hotbar_Lightweight from '@site/static/img/Hotbar_Lightweight.png';

const FeatureList = [
  {
    title: 'Easy to Use',
    Img: Hotbar_EasyToUse,
    description: (
      <>
        HotbarPlus uses simple and dynamic methods that you can call
        wherever and whenever.
      </>
    ),
  },
  {
    title: 'Lightweight',
    Img: Hotbar_Lightweight,
    description: (
      <>
        Streamlined and efficient with GoodSignal and Janitor, HotbarPlus
        causes minimal lag and memory leaks.
      </>
    ),
  },
  {
    title: 'Object-Oriented',
    Img: Hotbar_ObjectOriented,
    description: (
      <>
        Not only easy to use with default methods, but intuitive to modify
        and add your own.
      </>
    ),
  },
];

function Feature({Img, title, description}) {
  return (
    <div className={clsx('col col--4')}>
      <div className={styles.imgContainer + " text--center"}>
        <img className={styles.featureSvg} role="img" src={Img}/>
      </div>
      <div className="text--center padding-horiz--md">
        <Heading as="h3">{title}</Heading>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
