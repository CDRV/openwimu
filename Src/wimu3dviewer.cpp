#include "wimu3dviewer.h"

#include <QFile>
#include <QFileInfo>
#include <QStringList>
#include <QDebug>
#include <QMatrix4x4>
#include <QMatrix3x3>

#define _USE_MATH_DEFINES // for C++
#include <math.h>
//#include <GL/glu.h>

WIMU3DViewer::WIMU3DViewer(QWidget *parent, Qt::WindowFlags f) :
    QOpenGLWidget(parent,f)
{

}

void WIMU3DViewer::initializeGL()
{
    glClearColor(255,255,255,1);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_LIGHTING);
    glColorMaterial(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE);
    glEnable(GL_TEXTURE_2D);
    glShadeModel(GL_SMOOTH);
    glDepthFunc(GL_LEQUAL);


    GLfloat LightAmbient[]= { 0.5f, 0.5f, 0.5f, 0.5f };
    GLfloat LightDiffuse[]= { 0.75f, 0.75f, 0.75f, 1.0f };
    GLfloat LightPosition[]= { 0.0f, 1.0f, 0.0f, 1.0f };

    glLightfv(GL_LIGHT0, GL_AMBIENT, LightAmbient);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, LightDiffuse);
    glLightfv(GL_LIGHT0, GL_POSITION,LightPosition);

    glEnable(GL_LIGHT0);

    //loadFromOBJFile(QString("D:\\Simon_Dev\\WIMuGPS\\Workspace\\WIMUStudio2\\images\\WIMU3D_v2.obj"));
    loadFromOBJFile(":/3d/images/WIMU3D.obj");


}

void WIMU3DViewer::resizeGL(int width, int height)
{
    glViewport(0,0,width,height);

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glRotatef(90,0,0,1);
    glRotatef(270,1,0,0);
    glRotatef(90,0,1,0);

   /* glRotatef(90,0.f,1.f,0.f);

    // Calculate aspect ratio
    qreal aspect = qreal(width) / qreal(height ? height : 1);*/

    // Set near plane to 3.0, far plane to 7.0, field of view 45 degrees
    /*const qreal zNear = 0.1, zFar = 7.0;
    float fovy=45;
    GLdouble xmin, xmax, ymin, ymax;

    ymax = zNear * tan( fovy * M_PI / 360.0 );
    ymin = -ymax;
    xmin = ymin * aspect;
    xmax = ymax * aspect;

    glFrustum( xmin, xmax, ymin, ymax, zNear, zFar );*/

    //gluPerspective(45.f, aspect, zNear, zFar);
    //gluLookAt(0,0,15,0,0,0,0,1,0);
}


void WIMU3DViewer::paintGL()
{
   glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);



    glMatrixMode(GL_MODELVIEW);
   glLoadIdentity();

   // Rotation of model, depending of quaternion value
   QQuaternion world_mat = m_rotation * QQuaternion(0.707,0,0,0.707);
   QMatrix3x3 quat_mat = world_mat.toRotationMatrix();
   QMatrix4x4 rot_mat((QGenericMatrix<3,3,float>) quat_mat);
   glMultMatrixf(rot_mat.constData());



   /*glBegin(GL_TRIANGLES);

   // Dirty painting!
   for (int i=0; i<m_facets.count(); i++){
       glColor3d(0.2,0.2,0.2);
       for (int j=0; j<3; j++){
           int index = m_facets.at(i)[j] - 1;
           if (index<0 || index > m_vertexes.count()){
               qDebug() << "Wrong index!!";
               continue;
           }
           //glColor3d(0,255,0);
           if (!m_normals.empty()){
               int index_n = m_normals.at(i)[j]-1;
               if (index_n<0 || index_n > m_normalVectors.count()){
                   qDebug() << "Wrong normal index!!";
                   continue;
               }

               glNormal3d(m_normalVectors.at(index_n).x(),
                          m_normalVectors.at(index_n).y(),
                          m_normalVectors.at(index_n).z());
           }
           glVertex3d(m_vertexes.at(index).x(),
                      m_vertexes.at(index).y(),
                      m_vertexes.at(index).z()
                      );
       }
   }

   glEnd();*/

   // Clean painting!
   glEnableClientState(GL_VERTEX_ARRAY);						// Enable vertex arrays
   glEnableClientState(GL_NORMAL_ARRAY);						// Enable normal arrays
   glColor3d(0.2,0.2,0.2);
   glVertexPointer(3,GL_FLOAT,	0, m_triangles.constData());	// Vertex Pointer to triangle array
   glNormalPointer(GL_FLOAT,    0, m_triangleNormals.constData());		// Normal pointer to normal array
   glDrawArrays(GL_TRIANGLES,   0, m_triangles.count());		// Draw the triangles
   glDisableClientState(GL_VERTEX_ARRAY);						// Disable vertex arrays
   glDisableClientState(GL_NORMAL_ARRAY);

}

// Must be a triangulated file or will not work.
// Also, needs not to have normals in file... yet!
bool WIMU3DViewer::loadFromOBJFile(QString filename){
    QFile in_file(filename);
    QString line;

    QVector<QVector3D>    m_vertexes;
    QVector<QVector3D>    m_facets;
    QVector<QVector3D>    m_normalVectors;
    QVector<QVector3D>    m_normals;
    m_triangles.clear();
    m_triangleNormals.clear();

    bool rval = false;
    if (!in_file.exists()){
        return false;
    }

    if (in_file.open(QIODevice::ReadOnly)){
        // Read all lines
        while (!in_file.atEnd()){
            line = QString(in_file.readLine());

            // Object name
            if (line.at(0)=='o'){
                m_modelName = line.right(line.count()-2);
            }

            // Vertexes
            if (line.left(2)=="v "){
                QStringList values = line.split(" ");

                if (values.count()==4){
                    QVector3D v(QString(values.at(1)).toFloat(),
                                QString(values.at(2)).toFloat(),
                                QString(values.at(3)).toFloat());
                    m_vertexes.append(v);
                }
            }

            // Face
            if (line.at(0)=='f'){
                QStringList values = line.split(" ");

                if (values.count()==4){
                    if (QString(values.at(1)).contains("//")){
                        // We have normals to consider
                        QVector3D n;
                        for (int i=1; i<4; i++){
                            QStringList values2 = QString(values.at(i)).split("//");

                            if (values2.count()==2){
                                n[i-1] = QString(values2.at(1)).toInt();
                            }

                            values[i] = values2.at(0);
                        }
                        m_normals.append(n);

                    }
                    QVector3D f(QString(values.at(1)).toInt(),
                                QString(values.at(2)).toInt(),
                                QString(values.at(3)).toInt());
                    m_facets.append(f);
                }
            }

            // Normals
            if (line.left(2)=="vn"){
                QStringList values = line.split(" ");

                if (values.count()==4){
                    QVector3D n(QString(values.at(1)).toFloat(),
                                QString(values.at(2)).toFloat(),
                                QString(values.at(3)).toFloat());
                    m_normalVectors.append(n);
                }
            }

        }
        in_file.close();
        rval = true;
    }

    // Normalize between 0 and 1
    float max_x=0.f, max_y=0.f, max_z=0.f;
    for (int i=0; i<m_vertexes.count(); i++){
        max_x = qMax(max_x, qAbs(m_vertexes.at(i).x()));
        max_y = qMax(max_y, qAbs(m_vertexes.at(i).y()));
        max_z = qMax(max_z, qAbs(m_vertexes.at(i).z()));
    }

    for (int i=0; i<m_vertexes.count(); i++){
        m_vertexes[i].setX(m_vertexes.at(i).x()/max_x * .5);
        m_vertexes[i].setY(m_vertexes.at(i).y()/max_y * .75);
        m_vertexes[i].setZ(m_vertexes.at(i).z()/max_z * .25);
    }

    // Build triangles for better performance display with OpenGL
    for (int i=0; i<m_facets.count(); i++){
        for (int j=0; j<3; j++){
            if (!m_normals.empty()){
                int index_n = m_normals.at(i)[j]-1;
                if (index_n<0 || index_n > m_normalVectors.count()){
                    qDebug() << "Wrong normal index!!";
                    continue;
                }

                m_triangleNormals.append(m_normalVectors.at(index_n));
            }
            int index = m_facets.at(i)[j] - 1;
            if (index<0 || index > m_vertexes.count()){
                qDebug() << "Wrong index!!";
                continue;
            }
            m_triangles.append(m_vertexes.at(index));
        }
    }

    return rval;
}

void WIMU3DViewer::wheelEvent(QWheelEvent *event){
    Q_UNUSED(event);
   /*QPoint delta = event->angleDelta();

   QVector3D euler = m_rotation.toEulerAngles();

   if (delta.y()<0)
        //m_currentFOV = qMax(m_currentFOV-5,20.f);
       euler.setX(euler.x()-10);
   else
        //m_currentFOV = qMin(m_currentFOV+5,80.f);
       euler.setX(euler.x()+10);

    qDebug() << "Rot = " << euler.x();

    m_rotation = m_rotation.fromEulerAngles(euler);
    update();*/
}

void WIMU3DViewer::setRotation(QQuaternion rotation){
    m_rotation = rotation;
    update();
}
